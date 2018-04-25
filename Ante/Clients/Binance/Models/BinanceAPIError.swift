//
//  BinanceAPIError.swift
//  Ante
//
//  Created by Zameer Andani on 3/31/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct BinanceAPIError: AnteAPIError {
   let source: AnteDataSource = .binance
   
   let code: Int
   let message: String
   
   enum CodingKeys: String, CodingKey {
      case code
      case message = "msg"
   }
}
