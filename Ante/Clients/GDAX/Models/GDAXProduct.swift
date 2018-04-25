//
//  GDAXProduct.swift
//  Ante
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXProduct: AnteModel {
   let source: AnteDataSource = .gdax
   
   let id: String
   let baseCurrency: String
   let quoteCurrency: String
   let baseMinSize: String
   let baseMaxSize: String
   let quoteIncrement: String
   
   enum CodingKeys: String, CodingKey {
      case id
      case baseCurrency = "base_currency"
      case quoteCurrency = "quote_currency"
      case baseMinSize = "base_min_size"
      case baseMaxSize = "base_max_size"
      case quoteIncrement = "quote_increment"
   }
}
