//
//  GDAXCurrency.swift
//  Ante
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXCurrency: AnteModel {
   let source: AnteDataSource = .gdax
   
   let id: String
   let name: String
   let minSize: String
   
   enum CodingKeys: String, CodingKey {
      case id
      case name
      case minSize = "min-size"
   }
}

