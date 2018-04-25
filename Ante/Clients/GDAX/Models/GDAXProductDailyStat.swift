//
//  GDAXProductDailyStat.swift
//  Ante
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXProductDailyStat: AnteModel {
   let source: AnteDataSource = .gdax
   
   let open: String
   let high: String
   let low: String
   let volume: String
   
   enum CodingKeys: String, CodingKey {
      case open
      case high
      case low
      case volume
   }

}
