//
//  CPClient.swift
//  Ante
//
//  Created by Zameer Andani on 3/31/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

enum CPClientError: Error {
   case ConfigError(String)
}

struct CPClientBuilder {
   private static let baseAPIURLString = "https://api.binance.com"
   private static let baseSandboxAPIURLString = "https://api.binance.com"
   private static let wsURLString = "wss://stream.binance.com:9443"
   
   static func build(config: CPConfig, isSandbox: Bool) -> CPClient {
      let client = CPClient(
         config,
         isSandbox ? CPClientBuilder.baseSandboxAPIURLString : CPClientBuilder.baseAPIURLString)
      
      return client
   }
}

// contains all the config related to connecting to CryptoPanic
struct CPClient {
   
   public var config: CPConfig
   public var baseURLString: String
   
   public var `public`: CPPublicAPI {
      return _public!
   }
   
   internal var _public: CPPublicAPI?
   
   init(_ config: CPConfig, _ baseURLString: String) {
      self.config = config
      self.baseURLString = baseURLString
      
      self._public = CPPublicAPI(client: self)
   }
}
