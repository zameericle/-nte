//
//  GDAXAccount.swift
//  Ante
//
//  Created by Zameer Andani on 3/18/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXAccount: AnteAccount {
   let source: AnteDataSource = .gdax
   let id: String
   let currency: String
   let balance: Double
   let available: Double
   let hold: Double
   
   private var _lastTick: AnteTicker? 
   var lastTick: AnteTicker?
   
   enum CodingKeys: String, CodingKey {
      case id
      case currency
      case balance
      case available
      case hold
   }
   
   init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      self.id = try container.decode(String.self, forKey: .id)
      self.currency = try container.decode(String.self, forKey: .currency)
      
      let places = self.currency == "USD" ? 2 : 8
      
      self.balance = try Double(container.decode(String.self, forKey: .balance))!.roundTo(places: places)
      self.available = try Double(container.decode(String.self, forKey: .available))!.roundTo(places: places)
      self.hold = try Double(container.decode(String.self, forKey: .hold))!.roundTo(places: places)
   }
   
   func currencyPair(_ targetCurrency: String) -> String {
      return self.currency + "-" + targetCurrency
   }

}
