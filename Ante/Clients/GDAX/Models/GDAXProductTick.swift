//
//  GDAXProductTick.swift
//  Ante
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXProductTick: AnteModel {
   let source: AnteDataSource = .gdax
   
   let tradeId: Int
   let price: String
   let size: String
   let bid: String
   let ask: String
   let volume: String
   let time: Date
   
   enum CodingKeys: String, CodingKey {
      case tradeId = "trade_id"
      case price
      case size
      case bid
      case ask
      case volume
      case time
   }
}
