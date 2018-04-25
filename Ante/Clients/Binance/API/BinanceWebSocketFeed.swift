//
//  BinanceWebSocketFeed.swift
//  Ante
//
//  Created by Zameer Andani on 3/31/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

class BinanceWebSocketFeed: AnteWebSocketFeed {

   let client: BinanceClient
   
   override var source: AnteDataSource {
      get {
         return .binance
      }
   }
   
   override var queueName: String {
      get {
         return "com.shabash.Ante.binance.websocketfeed"
      }
   }

   
   init(client: BinanceClient) {
      self.client = client
      super.init()
   }
   
   override public func decodeText(_ decoder: JSONDecoder, _ text: String) throws -> AnteTicker {
      return try decoder.decode(BinanceTicker.self, from: text.data(using: .utf8)!)
   }
   
   override func subscribeTo(productIds: [String], channels: [String]) throws {
      // do nothing
   }
   
   override func unsubscribeTo(productIds: [String], channels: [String]) throws {
      // do nothing
   }
}
