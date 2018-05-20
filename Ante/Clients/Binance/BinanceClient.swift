//
//  BinanceClient.swift
//  Ante
//
//  Created by Zameer Andani on 3/31/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

enum BinanceClientError: Error {
   case ConfigError(String)
}

struct BinanceClientBuilder {
   private static let baseAPIURLString = "https://api.binance.com"
   private static let baseSandboxAPIURLString = "https://api.binance.com"
   private static let wsURLString = "wss://stream.binance.com:9443"
   
   static func build(config: BinanceConfig, isSandbox: Bool) -> BinanceClient {
      let client = BinanceClient(
         config,
         isSandbox ? BinanceClientBuilder.baseSandboxAPIURLString : BinanceClientBuilder.baseAPIURLString,
         wsURLString)
      
      return client
   }
}

// contains all the config related to connecting to Binance
struct BinanceClient {
   
   public var config: BinanceConfig
   public var baseURLString: String
   public var wsURLString: String
   
   
   public var decodedSecret: Data?
   
   public var ws: BinanceWebSocketFeed?
   
   public var `private`: BinancePrivateAPI {
      return _private!
   }
   
   internal var _private: BinancePrivateAPI?
   
   init(_ config: BinanceConfig, _ baseURLString: String, _ wsURLString: String) {
      self.config = config
      self.baseURLString = baseURLString
      self.wsURLString = wsURLString
      
      self.ws = BinanceWebSocketFeed(client: self)
      self._private = BinancePrivateAPI(client: self)
   }
}
