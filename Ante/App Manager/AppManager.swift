//
//  AppManager.swift
//  Ante
//
//  Created by Zameer Andani on 3/27/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

typealias PriceConversionFunc = (Double) -> (Double)

class AppManager {
   static let sharedInstance = AppManager()
   let queue = DispatchQueue(label: "com.shabash.Ante.AppManagerQueue")
   
   let accountsModel: AccountsModel = AccountsModel("USD")
   
   private var repositories: [AnteRepository] = []
   private let binanceClient: BinanceClient
   private let gdaxClient: GDAXClient
   
   private init() {
      self.binanceClient = BinanceClientBuilder.build(config: KeyManager.binanceInfo(), isSandbox: false)
      self.repositories.append(BinanceRepository(client: self.binanceClient))
      self.gdaxClient = GDAXClientBuilder.build(config: KeyManager.gdaxInfo(), isSandbox: false)
      self.repositories.append(GDAXRepository(client: self.gdaxClient))
      self.accountsModel.delegate = self
   }
   
   public func priceConvertor(source: AnteDataSource, fromCurrency: String) -> PriceConversionFunc {
      var conversion: Double?
      
      if (source == .binance) {
         // all binance prices are in BTC ; convert using BTCUSDT
         let btcustd = self.accountsModel.filter { model in
            return model.currency == "BTC"
         }
         
         conversion = btcustd[0].lastTick?.price
      } 
      
      func convert(_ amt: Double) -> Double {
         if let conversion = conversion {
            return amt * conversion
         }
         
         return amt
      }
      
      return convert
   }
}

typealias AppManagerDataAccess = AppManager
extension AppManagerDataAccess {
   func refresh(completion: @escaping (AccountsModel, [Error]?) -> Void) {
      let count = repositories.count
      var idx = 0
      var errors = [Error]()
      
      repositories.forEach { repository in
         repository.fetchAllAccounts { accounts, err in
            print("\(repository.source) loading completed")
            self.queue.sync {
               idx = idx + 1
               if let err = err {
                  errors.append(err)
               }
               
               if let accounts = accounts {
                  self.accountsModel.append(contentsOf: accounts)
               }
            
               if (idx == count) {
                  completion(self.accountsModel, errors.count > 0 ? errors : nil)
               }
            }
         }
      }
   }
}

typealias AppManagerAccountsModelDelegate = AppManager
extension AppManagerAccountsModelDelegate: AccountsModelDelegate {
   func connectionURLStringForSource(_ source: AnteDataSource) -> String {
      var urlString = ""
      switch(source) {
         case .gdax: urlString = self.gdaxClient.wsURLString
         case .binance: urlString = self.binanceClient.wsURLString
         default: urlString = ""
      }
      
      return urlString
   }
   
   func feedAPIs() -> [AnteWebSocketFeed] {
      return [self.gdaxClient.ws!, self.binanceClient.ws!]
   }
}
