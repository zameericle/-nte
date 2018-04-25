//
//  GDAXTime.swift
//  Ante
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXTime: AnteModel {
   let source: AnteDataSource = .gdax
   
   let iso: Date
   let epoch: Double
   
   enum CodingKeys: String, CodingKey {
      case iso
      case epoch
   }
}
