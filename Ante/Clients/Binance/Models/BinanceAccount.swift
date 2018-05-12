//
//  BinanceAccount.swift
//  Ante
//
//  Created by Zameer Andani on 3/31/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct BinanceAccounts: AnteModel {
   let source: AnteDataSource = .binance
   let balances: [BinanceAccount]
   
   enum CodingKeys: String, CodingKey {
      case balances
   }
}

struct BinanceAccount: AnteAccount {
   let source: AnteDataSource = .binance
   
   let id: String
   let currency: String
   let balance: Double
   let available: Double
   let hold: Double
   
   var lastTick: AnteTicker?
   
   enum CodingKeys: String, CodingKey {
      case currency = "asset"
      case available = "free"
      case hold = "locked"
   }
   
   init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      self.id = UUID().uuidString
      self.currency = try container.decode(String.self, forKey: .currency)

      let places = self.currency == "USD" ? 2 : 8
      
      self.available = try Double(container.decode(String.self, forKey: .available))!.roundTo(places: places)
      self.hold = try Double(container.decode(String.self, forKey: .hold))!.roundTo(places: places)
      
      self.balance = self.available + self.hold
   }
   
   func currencyPair(_ targetCurrency: String) -> String {
      return (self.currency == "BTC") ? self.currency + "USDT" : self.currency + "BTC"
   }

}
