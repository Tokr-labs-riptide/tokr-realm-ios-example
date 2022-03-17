//
//  RnftExampleViewModel.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import Foundation
import Solana

class RnftExampleViewModel: ObservableObject {
    
    // ============================================================
    // === Internal API ===========================================
    // ============================================================
    
    // MARK: Internal Properties
    
    @Published var rnft: Rnft?
    
    let publicKey = PublicKey(string: "")
    
    // MARK: Internal Methods
    
    func getExampleRnft() {
        
        
        
    }
    
    // ============================================================
    // === Private API ============================================
    // ============================================================
    
    // MARK: Private Properties
    
    private let rnftService = RnftService()
    
    // MARK: Private Methods
    
}
