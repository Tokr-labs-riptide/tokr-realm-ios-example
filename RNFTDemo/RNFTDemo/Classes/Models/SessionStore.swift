//
//  SessionStore.swift
//  HelloTorusSolana
//
//  Created by Eric McGary on 3/9/22.
//

import Foundation
import Solana

class SessionStore: ObservableObject {
    
    static var shared = SessionStore()
    
    init() {
        
        accountStorage = InMemoryAccountStorage()
        
        network = NetworkingRouter(
            endpoint: .devnetSolana
        )
        
        solanaClient = Solana(
            router: network,
            accountStorage: accountStorage,
            tokenProvider: EmptyInfoTokenProvider()
        )
        
    }
    
    let network: NetworkingRouter
    let solanaClient: Solana
    let accountStorage: InMemoryAccountStorage
    
}
