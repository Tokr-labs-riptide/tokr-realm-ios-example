//
//  TokrNftService.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import Foundation
import Solana

struct TokrNftService {
    
    // ============================================================
    // === Internal API ===========================================
    // ============================================================
    
    // MARK: Internal Methods
    
    func fetchRnfts(completion: @escaping (Result<[Rnft], Error>) -> Void) {
        
        session.accountStorage.account
            .onSuccess({ account in
                
                session.solanaClient.action.getTokenWallets(account: account.publicKey.base58EncodedString) { result in
                 
                    DispatchQueue.main.async {
                        
                        switch result {
                            case .success(let wallets):
                                print(wallets)
                                completion(.success([]))
                            case .failure(let error):
                                completion(.failure(error))
                        }
                        
                    }
                    
                }
                
            })
            .onFailure { error in
                
                DispatchQueue.main.async {
                    
                    completion(.failure(error))
                    
                }
                
            }
        
    }
    
    // ============================================================
    // === Private API ============================================
    // ============================================================
    
    // MARK: Private Properties
    
    private let session = SessionStore.shared
    
}
