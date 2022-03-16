//
//  InMemoryAccountStorage.swift
//  HelloTorusSolana
//
//  Created by Eric McGary on 2/25/22.
//

import Foundation
import Solana

class InMemoryAccountStorage: SolanaAccountStorage {
    
    private var _account: Account?
    
    func save(_ account: Account) -> Result<Void, Error> {
        _account = account
        return .success(())
    }
    
    var account: Result<Account, Error> {
        if let account = _account {
            return .success(account)
        }
        return .failure(SolanaError.unauthorized)
    }
    
    @discardableResult func clear() -> Result<Void, Error> {
        _account = nil
        return .success(())
    }
    
}
