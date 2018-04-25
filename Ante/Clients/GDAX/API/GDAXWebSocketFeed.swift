//
//  GDAXWebSocketFeed.swift
//  Ante
//
//  Created by Zameer Andani on 3/27/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXWSRequestMessage: Decodable, Encodable {
   let type: String
   let productIds: [String]
   let channels: [String]
   
   enum CodingKeys: String, CodingKey {
      case type
      case productIds = "product_ids"
      case channels
   }
   
   init(_ type: String, _ productIds: [String], _ channels: [String]) {
      self.type = type
      self.productIds = productIds
      self.channels = channels
   }
}

class GDAXWebSocketFeed: AnteWebSocketFeed {
   
   override var source: AnteDataSource {
      get {
         return .gdax
      }
   }
   
   override var queueName: String {
      get {
         return "com.shabash.Ante.gdax.websocketfeed"
      }
   }

   let client: GDAXClient
   
   init(client: GDAXClient) {
      self.client = client
      super.init()
   }
 
   override public func decodeText(_ decoder: JSONDecoder, _ text: String) throws -> AnteTicker {
      return try decoder.decode(GDAXTicker.self, from: text.data(using: .utf8)!)
   }
   
   override public func subscribeTo(productIds: [String], channels: [String]) throws {
      if (super.socket!.isConnected) {
         let msg = GDAXWSRequestMessage("subscribe", productIds, ["ticker"])
         let data = try JSONEncoder().encode(msg)
         super.socket!.write(string: String(data: data, encoding: .utf8)!)
      } else {
         throw AnteWebSocketError.NotConnected
      }
   }
   
   override public func unsubscribeTo(productIds: [String], channels: [String]) throws {
      if (super.socket!.isConnected) {
         let msg = GDAXWSRequestMessage("unsubscribe", productIds, ["ticker"])
         let data = try JSONEncoder().encode(msg)
         super.socket!.write(string: String(data: data, encoding: .utf8)!)
      } else {
         throw AnteWebSocketError.NotConnected
      }
   }
}
