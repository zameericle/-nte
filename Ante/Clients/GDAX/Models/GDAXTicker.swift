//
//  GDAXTicker.swift
//  Ante
//
//  Created by Zameer Andani on 3/27/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXTicker: AnteTicker {
   let source: AnteDataSource = .gdax
   let type: String
   let sequence: Int64
   let productId: String
   let price: Double
   let open24h: Double
   let volume24h: Double
   let low24h: Double
   let high24h: Double
   let volume30d: Double
   let bestBid: Double
   let bestAsk: Double
   let side: String?
   let time: Date?
   let tradeId: Int64?
   let lastSize: Double?
   
   enum CodingKeys: String, CodingKey {
      case type
      case sequence
      case productId = "product_id"
      case price
      case open24h = "open_24h"
      case volume24h = "volume_24h"
      case low24h = "low_24h"
      case high24h = "high_24h"
      case volume30d = "volume_30d"
      case bestBid = "best_bid"
      case bestAsk = "best_ask"
      case side
      case time
      case tradeId = "trade_id"
      case lastSize = "last_size"
   }
   
   init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      
      self.type = try container.decode(String.self, forKey: .type)
      self.sequence = try container.decode(Int64.self, forKey: .sequence)
      self.productId = try container.decode(String.self, forKey: .productId)
      
      let places = self.productId.contains("USD") ? 2 : 8
      
      self.price = try Double(container.decode(String.self, forKey: .price))!.roundTo(places: places)
      self.open24h = try Double(container.decode(String.self, forKey: .open24h))!.roundTo(places: places)
      self.volume24h = try Double(container.decode(String.self, forKey: .volume24h))!.roundTo(places: places)
      self.low24h = try Double(container.decode(String.self, forKey: .low24h))!.roundTo(places: places)
      self.high24h = try Double(container.decode(String.self, forKey: .high24h))!.roundTo(places: places)
      self.volume30d = try Double(container.decode(String.self, forKey: .volume30d))!.roundTo(places: places)
      self.bestBid = try Double(container.decode(String.self, forKey: .bestBid))!.roundTo(places: places)
      self.bestAsk = try Double(container.decode(String.self, forKey: .bestAsk))!.roundTo(places: places)
      self.side = try? container.decode(String.self, forKey: .side)
      self.time = try? container.decode(Date.self, forKey: .time)
      
      self.tradeId = try? container.decode(Int64.self, forKey: .tradeId)
      
      self.lastSize = try? Double(container.decode(String.self, forKey: .lastSize))!.roundTo(places: places)
   }
}
