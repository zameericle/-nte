//
//  GDAXHistoricRate.swift
//  Ante
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXHistoricRate: AnteModel {
   let source: AnteDataSource = .gdax
   
   let time: Date
   let low: Double
   let high: Double
   let open: Double
   let close: Double
   let volume: Double
   
   init(from decoder: Decoder) throws {
      var container = try decoder.unkeyedContainer()
      
      let epoch = TimeInterval(try container.decode(Int.self))
      self.time = Date(timeIntervalSince1970: epoch)
      self.low = try container.decode(Double.self)
      self.high = try container.decode(Double.self)
      self.open = try container.decode(Double.self)
      self.close = try container.decode(Double.self)
      self.volume = try container.decode(Double.self)
   }
}
