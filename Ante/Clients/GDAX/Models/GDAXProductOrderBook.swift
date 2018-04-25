//
//  GDAXProductOrderBook.swift
//  Ante
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXProductOrder: AnteModel {
   let source: AnteDataSource = .gdax
   
   let price: String
   let size: String
   let numOrders: Int
   
   init(from decoder: Decoder) throws {
      var container = try decoder.unkeyedContainer()
      
      self.price = try container.decode(String.self)
      self.size = try container.decode(String.self)
      self.numOrders = try container.decode(Int.self)
   }
}

struct GDAXProductOrderBook: Decodable {
   let sequence: Int
   let bids: [GDAXProductOrder]
   let asks: [GDAXProductOrder]
}
