//
//  TokrNftService.swift
//  RNFTDemo
//
//  Created by Eric McGary on 3/16/22.
//

import Foundation
import Solana
import Combine
import Metaplex

enum TokrNftServiceError: Error {
    case invalidUri
    case arweave
    case decodeIssue
    case metadataFailed
}

class TokrNftService {
    
    // ============================================================
    // === Internal API ===========================================
    // ============================================================
    
    // MARK: Internal Methods
    
    func fetchRnfts() -> Future<[Rnft], Error> {
  
        return Future { promise in
            self.getRnfts()
                .sink {
                    
                    if case let .failure(error) = $0 {
                        promise(.failure(error))
                        return
                    }
                    
                } receiveValue: {
                    
                    let rnfts: [Rnft] = $0.filter({ return $0 != nil}) as? [Rnft] ?? []
                    
                    promise(.success(rnfts))
                }
                .store(in: &self.cancellables)
        }
       
        
    }
    
    // ============================================================
    // === Private API ============================================
    // ============================================================
    
    // MARK: Private Properties
    
    private let session = SessionStore.shared
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: Private Methods
    
    private func getRnfts() -> Future<[Rnft?], Error> {
        
        return Future { promise in

            self.getTokenWallets()
                .mapError({$0 as Error})
                .eraseToAnyPublisher()
                .flatMap({ wallets -> AnyPublisher<Wallet, Error> in
                    
                    Publishers.Sequence(sequence: wallets)
                        .mapError({$0 as Error})
                        .eraseToAnyPublisher()
 
                })
                .flatMap { wallet -> AnyPublisher<AccountInfo?, Error> in
                    
                    return self.getAccountInfo(publicKey: wallet.pubkey)
                        .mapError({$0 as Error})
                        .eraseToAnyPublisher()
                    
                }
                .flatMap { accountInfo -> AnyPublisher<Rnft?, Error> in
    
                    guard let accountInfo = accountInfo else {
                        
                        return Just(nil)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                        
                    }
                    
                    return self.getMetadata(publicKey: accountInfo.mint)
                        .mapError({$0 as Error})
                        .eraseToAnyPublisher()
                    
                }
                .collect()
                .sink { completion in
                    
                    switch completion {
                        case .failure(_): promise(.success([]))
                        default: break
                    }
                    
                } receiveValue: { result in
                    
                    promise(.success(result))
                    
                }
                .store(in: &self.cancellables)

            
            
        }
        
    }
    
    private func getTokenWallets() -> Future<[Wallet],Error> {
        
        return Future { promise in
                        
            self.session.accountStorage.account
                .onSuccess({ account in
                    
                    self.session.solanaClient.action.getTokenWallets(account: account.publicKey.base58EncodedString) { result in
                     
                        DispatchQueue.main.async {
                            
                            switch result {
                                case .success(let wallets):
                                    promise(.success(wallets))
                                case .failure(let error):
                                    promise(.failure(error))
                            }
                            
                        }
                        
                    }
                    
                })
                .onFailure { error in
                    promise(.failure(error))
                }
            
            
            
            
        }
        
    }
    
    private func getAccountInfo(publicKey: String) -> Future<AccountInfo?,Error> {
        
        return Future { promise in
                        
            self.session.solanaClient.api.getAccountInfo(
                account: publicKey,
                decodedTo: AccountInfo.self
            ) { result in
                
                switch result {
                    case .success(let info):
                        promise(.success(info.data.value))
                        
                    case .failure(_):
                        promise(.success(nil))
                        
                }
                
            }
            
        }
        
    }
    
    private func getMetadata(publicKey: PublicKey) -> Future<Rnft?, TokrNftServiceError> {
        
        return Future { promise in
                        
            let metadata = MetaplexActions.GetMetadata(tokenMint: publicKey)
            
            self.session.solanaClient.action.perform(metadata) { result in
                switch result {
                    case .success(let token):
                        
                        self.session.solanaClient.api.getAccountInfo(
                            account: token.base58EncodedString,
                            decodedTo: Metaplex.Metadata.self
                        ) { result in
                            switch result {
                                case .success(let info):
                                    
                                    guard let uri = info.data.value?.data.uri, let url = URL(string: uri) else {
                                        promise(.success(nil))
                                        return
                                    }
                                    
                                    URLSession.shared.dataTask(
                                        with: url
                                    ) { data, response, error in
                                        
                                        guard error == nil else {
                                            promise(.success(nil))
                                            return
                                        }

                                        do {
                                            
                                            let rnft = try JSONDecoder().decode(Rnft.self, from: data!)
                                            promise(.success(rnft))
                                            
                                        } catch {
                                            promise(.success(nil))
                                        }
                                        
                                    }.resume()

                                case .failure(_):
                                    promise(.success(nil))
                            }
                        }

                    case .failure(_):
                        promise(.success(nil))
                        
                }
                
            }
            
        }
        
    }
    
}
