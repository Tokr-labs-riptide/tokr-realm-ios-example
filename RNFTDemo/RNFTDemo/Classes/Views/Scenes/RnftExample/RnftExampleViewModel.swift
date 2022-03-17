//
//  RnftExampleViewModel.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import Foundation
import Solana
import Combine

class RnftExampleViewModel: ObservableObject {
    
    // ============================================================
    // === Internal API ===========================================
    // ============================================================
    
    // MARK: Internal Properties
    
    @Published var isLoading = false
    @Published var rnft: Rnft?
    @Published var shouldShowErrorMessage = false
    @Published var errorMessage = ""
    
    let publicKey = PublicKey(string: "5V76YL8BbjHKhSKtfLFezE6V3ybb1ntJExKKorPuxZPB")
    
    // MARK: Internal Methods
    
    func getExampleRnft() {
        
        guard let publicKey = publicKey else {
            isLoading = false
            return
        }
        
        isLoading = true
        
        rnftService.fetchRnft(publicKey: publicKey)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                
                self.isLoading = false
                
                if case let .failure(error) = completion {
                    self.shouldShowErrorMessage = true
                    self.errorMessage = error.localizedDescription
                    return
                }
                
            } receiveValue: { rnft in
                self.rnft = rnft
            }
            .store(in: &cancellables)

        
    }
    
    // ============================================================
    // === Private API ============================================
    // ============================================================
    
    // MARK: Private Properties
    
    private let rnftService = RnftService()
    private var cancellables = Set<AnyCancellable>()
    
}
