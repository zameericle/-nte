//
//  CPRepository.swift
//  Ante
//
//  Created by Zameer Andani on 5/22/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct CPRepository: AnteRepository {
   
   var source: AnteDataSource = .cryptopanic
   
   private let binanceClient: BinanceClient
   
   init(client: BinanceClient) {
      self.binanceClient = client
   }
   
   func fetchAllAccounts(completion: @escaping ([AnteAccount]?, Error?) -> Void) {
      self.binanceClient.private.accounts() {
         result in
         
         switch result {
         case .Success(let accounts) : completion(accounts.balances, nil)
         case .Failure(let err) : completion(nil, err)
         }
      }
   }
}
