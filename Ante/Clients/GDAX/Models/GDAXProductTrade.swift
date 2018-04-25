//
//  GDAXTrade.swift
//  Ante
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXProductTrade: AnteModel {
   let source: AnteDataSource = .gdax
   
   let tradeId: Int
   let price: String
   let size: String
   let side: String
   let time: Date
   
   enum CodingKeys: String, CodingKey {
      case tradeId = "trade_id"
      case price
      case size
      case side
      case time
   }
}
