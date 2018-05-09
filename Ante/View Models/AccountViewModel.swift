//
//  AccountViewModel.swift
//  Ante
//
//  Created by Zameer Andani on 4/1/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct AccountViewModel {
   internal var model: AnteAccount

   var id: String {
      return model.id
   }
   
   var source: AnteDataSource {
      return model.source
   }
   
   var currency: String {
      return model.currency
   }
   
   var balance: String {
      return String(format: "%0.8f %@", model.balance, self.currency)
   }

   internal var _balance: Double {
      return model.balance
   }

   internal var _value: Double? {
      if let price = self.model.lastTick?.price {
         return AppManager.sharedInstance.priceConvertor(source: self.source, fromCurrency: self.currency)(price * model.balance)
      }
      
      return nil
   }
   
   var value: String {
      if let value = self._value {
         return "\(value.withCommasAsCurrency(2))"
      } else {
         return "$--.--"
      }
   }

   private var glyph: String {
      get {
         if let price = self.model.lastTick?.price, let open24 = self.model.lastTick?.open24h {
            if (price > open24) {
               return "▲"
            } else if (price < open24) {
               return "▼"
            } else {
               return "―"
            }
         }
         return "-"
      }
   }
   
   var price: String {
      if let price = self.model.lastTick?.price {
         let convertedPrice = AppManager.sharedInstance.priceConvertor(source: self.source, fromCurrency: self.currency)(price)
         let precision = convertedPrice < 1 ? 6 : 2
         
         return "\(convertedPrice.withCommasAsCurrency(precision))"
      } else {
         return "$--.--"
      }
   }
   
   var _gainLoss: (Double, Double)? {
      if let price = self.model.lastTick?.price, let open24 = self.model.lastTick?.open24h {
         return ((price - open24), (price - open24)/open24)
      } else {
         return nil
      }
   }

   var gainLoss: String {
      if let gainLoss = self._gainLoss {
         let convertedPrice = AppManager.sharedInstance.priceConvertor(source: self.source, fromCurrency: self.currency)(gainLoss.0)
         let precision = abs(convertedPrice) < 1 ? 6 : 2
         
         return "\(convertedPrice.withCommasAsCurrency(precision)) \(self.glyph) \(gainLoss.1.withCommasAsPercent(2))"
      } else {
         return "--.-- - --.--"
      }
   }
   
   init(_ model: AnteAccount) {
      self.model = model
   }
}
