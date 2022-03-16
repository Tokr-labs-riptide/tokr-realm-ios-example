//
//  ContentViewModel.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import Foundation
import Combine
import Solana

class ContentViewModel: ObservableObject {
    
    // ============================================================
    // === Public API =============================================
    // ============================================================
    
    // MARK: Public Properties
    
    @Published var isLoggingIn = false
    @Published var isLoggedIn = false
    @Published var privateKey: String?
    @Published var shouldShowErrorMessage = false
    @Published var errorMessage = ""
    @Published var solanaResult = ""
    @Published var rnfts = [Rnft]()
    
    // MARK: Public Methods
    
    func login() {

        isLoggingIn = true
        
        guard let privateKey = Bundle.main.object(forInfoDictionaryKey: "SOLANA_PRIVATE_KEY") as? String else {
            isLoggingIn = false
            shouldShowErrorMessage = true
            errorMessage = "Solana private key not set in Debug.xcconfig."
            return
        }
        
        guard let account = Account(secretKey: Data(Base58.decode(privateKey))) else {
            isLoggingIn = false
            shouldShowErrorMessage = true
            errorMessage = "Could not generate account from private key."
            return
        }
        
        self.session.solanaClient.auth.save(account)
            .onFailure { error in
                
                self.isLoggingIn = false
                self.shouldShowErrorMessage = true
                self.errorMessage = error.localizedDescription
                
            }.onSuccess { _ in
                
                self.isLoggingIn = false
                self.isLoggedIn = true
                self.getRnfts()
                
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
    private let tokrNftService = TokrNftService()
    
    // MARK: Private Methods
    
    private func getRnfts() {
        
        tokrNftService.fetchRnfts { result in
            switch result {
                case .success(let rnfts):
                    self.rnfts = rnfts
                case .failure(let error):
                    self.shouldShowErrorMessage = true
                    self.errorMessage = "Fetching rnfts failed with error \(error.localizedDescription)"
            }
        }
        
    }
    
}
