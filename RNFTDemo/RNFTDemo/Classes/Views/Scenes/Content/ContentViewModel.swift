//
//  ContentViewModel.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import Foundation
import Combine
import Solana
import OpenLogin

class ContentViewModel: ObservableObject {
    
    // ============================================================
    // === Public API =============================================
    // ============================================================
    
    // MARK: Public Properties
    
    @Published var isLoggingIn = false
    @Published var isLoggedIn = false
    @Published var isLoading = false
    @Published var privateKey: String?
    @Published var shouldShowErrorMessage = false
    @Published var errorMessage = ""
    @Published var solanaResult = ""
    @Published var rnfts = [Rnft]()
    
    var solanaPublicKeyShortString: String {
        return solanaPublicKey?.short() ?? ""
    }
    
    var solanaPublicKeyString: String {
        return solanaPublicKey?.base58EncodedString ?? ""
    }
    
    var solanaPublicKey: PublicKey?
    
    // MARK: Public Methods
    
    func login() {
        
        guard !isLoggingIn else {
            return
        }
        
        isLoggingIn = true
        
        guard let openLoginClientId = Bundle.main.object(forInfoDictionaryKey: "OPEN_LOGIN_CLIENT_ID") as? String else {
            isLoggingIn = false
            shouldShowErrorMessage = true
            errorMessage = "OpenLogin ID not set in Debug.xcconfig."
            return
        }
        
        OpenLogin(
            OLInitParams(
                clientId: openLoginClientId,
                network: .testnet
            )
        )
            .login(
                
                OLLoginParams(
                    loginProvider: .GITHUB
                )
                
            ) { result in
                
                switch result {
                        
                    case .success(let state):
                        
                        let account = Account(secretKey: state.privKey.data(using: .utf8)!)!
                        
                        self.session.solanaClient.auth.save(account)
                            .onFailure { error in
                                self.isLoggingIn = false
                                self.shouldShowErrorMessage = true
                                self.errorMessage = error.localizedDescription
                            }.onSuccess { _ in
                                self.solanaPublicKey = account.publicKey
                                self.isLoggedIn = true
                                self.isLoggingIn = false
                                self.getRnfts()
                            }
                        
                    case .failure(let error):
                        
                        self.isLoggingIn = false
                        self.shouldShowErrorMessage = true
                        self.errorMessage = error.localizedDescription
                        
                }
                
            }
        
    }
    
    func logout() {
        
        session.accountStorage.clear()
        isLoggedIn = false
        
    }
    
    // ============================================================
    // === Private API ============================================
    // ============================================================
    
    // MARK: Private Properties
    
    private var cancellables = Set<AnyCancellable>()
    private var mintAddresses = [String]()
    private let session = SessionStore.shared
    private let tokrNftService = RnftService()
    
    // MARK: Private Methods
    
    private func getRnfts() {
        
        isLoading = true
        
        tokrNftService.fetchRnfts()
            .receive(on: DispatchQueue.main)
            .sink {
                
                self.isLoading = false
                
                if case let .failure(error) = $0 {
                    self.isLoading = false
                    self.shouldShowErrorMessage = true
                    self.errorMessage = "Fetching rnfts failed with error \(error.localizedDescription)"
                    return
                }
                
            } receiveValue: { rnfts in
                self.rnfts = rnfts
            }
            .store(in: &cancellables)
        
    }
    
}
