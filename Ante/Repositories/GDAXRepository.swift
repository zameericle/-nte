//
//  GDAXRepository.swift
//  Ante
//
//  Created by Zameer Andani on 3/23/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXRepository: AnteRepository {
   
   var source: AnteDataSource = .gdax
   
   private let gdaxClient: GDAXClient
   
   init(client: GDAXClient) {
      self.gdaxClient = client
   }
}

extension GDAXRepository: CryptoCurrencyRepository {
   func fetchAllAccounts(completion: @escaping ([AnteAccount]?, Error?) -> Void) {
      self.gdaxClient.private.accounts() {
         result in
         
         switch result {
         case .Success(let accounts) : completion(accounts, nil)
         case .Failure(let err) : completion(nil, err)
         }
      }
   }
}
