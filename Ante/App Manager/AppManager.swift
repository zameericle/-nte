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
   
   let accountsModel: AccountsModel = AccountsModel("USD")
   
   private var repositories: [AnteRepository] = []
   private let binanceClient: BinanceClient
   private let gdaxClient: GDAXClient
   
   
   var feedAPIs: [AnteWebSocketFeed] {
      get {
         return [self.gdaxClient.ws!, self.binanceClient.ws!]
      }
   }
   
   private init() {
      self.binanceClient = BinanceClientBuilder.build(config: KeyManager.binanceInfo(), isSandbox: false)
      self.repositories.append(BinanceRepository(client: self.binanceClient))
      self.gdaxClient = GDAXClientBuilder.build(config: KeyManager.gdaxInfo(), isSandbox: false)
      self.repositories.append(GDAXRepository(client: self.gdaxClient))
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
   
   func refresh(completion: @escaping (AnteDataSource, [AnteAccount]?, Error?) -> Void) {
      repositories.forEach { repository in
         repository.fetchAllAccounts { accounts, err in
            if let accounts = accounts {
               self.accountsModel.append(contentsOf: accounts)
            }
            
            completion(repository.source, accounts, err)
         }
      }
   }
}

typealias AppManagerTickerUpdates = AppManager
extension AppManagerTickerUpdates {
   func startTickerUpdates() throws {
      let sources = self.accountsModel.map { account in
         return account.source
      }
      
      let feedApis = self.feedAPIs.filter { api in
         return sources.contains(api.source)
      }
      
      try feedApis.forEach { api in
         api.delegate = self
         try api.connect()
      }
   }
   
   func stopTickerUpdates() throws {
      let sources = self.accountsModel.map { account in
         return account.source
      }
      
      let feedApis = self.feedAPIs.filter { api in
         return sources.contains(api.source)
      }
      
      try feedApis.forEach { api in
         api.delegate = self
         try api.disconnect()
      }
   }
}

typealias AppManagerWebSocketFeedDelegate = AppManager
extension AppManagerWebSocketFeedDelegate: AnteWebSocketFeedDelegate {
   private func generateProductIds(source: AnteDataSource) -> [String] {
      return self.accountsModel.filter { model in
            return model.source == source
         }.filter { model in
            return model.balance > 0.00
         }.map { model in
            return model.currencyPair(self.accountsModel.defaultCurrency)
         }
      }
   
   func connectionURL(ws: AnteWebSocketFeed) -> URL {
      switch(ws.source) {
         case .gdax: return URL(string: gdaxClient.wsURLString)!
         case .binance:
            let productIds = generateProductIds(source: ws.source)
            var params = ""
            productIds.forEach { productId in
               params += "\(productId.lowercased())@ticker/"
            }
            
            params.remove(at: params.index(before: params.endIndex))
            print(params)
            return URL(string: "\(self.binanceClient.wsURLString)/stream?streams=\(params)")!
         case .unknown: return URL(string: "")!
      }
   }
   
   func onConnect(ws: AnteWebSocketFeed) {
      print("connected")
      do {
         let productIds = generateProductIds(source: ws.source)
         try ws.subscribeTo(productIds: productIds, channels: ["ticker"])
      } catch (let err) {
         print("Error: \(err)")
      }
   }
   
   func onDisconnect(ws: AnteWebSocketFeed, error: Error?) {
      print("disconnected")
   }
   
   func onTickerUpdate(_ ws: AnteWebSocketFeed, _ tick: AnteTicker) {
      self.accountsModel.updateModelWithTickerUpdate(tick)
   }
}
