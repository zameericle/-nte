//
//  GDAXService.swift
//  Ante
//
//  Heavily inspired by: https://github.com/anthonypuppo/GDAXSwift
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//
import Foundation

enum GDAXClientError: Error {
   case ConfigError(String)
}

struct GDAXClientBuilder {
   private static let baseAPIURLString = "https://api.gdax.com"
   private static let baseSandboxAPIURLString = "https://api-public.sandbox.gdax.com"
   private static let wsURLString = "wss://ws-feed.gdax.com"
   
   static func build(config: GDAXConfig, isSandbox: Bool) -> GDAXClient {
      let decodedSecret = Data(base64Encoded: config.secret)
      
      let client = GDAXClient(
         config,
         isSandbox ? GDAXClientBuilder.baseSandboxAPIURLString : GDAXClientBuilder.baseAPIURLString,
         wsURLString,
         decodedSecret)
      
      return client
   }
}

// contains all the config related to connecting to GDAX
struct GDAXClient {
   
   public var config: GDAXConfig
   public var baseURLString: String
   public var wsURLString: String
   public var decodedSecret: Data?
   
   public var ws: GDAXWebSocketFeed?
   
   public var `public`: GDAXPublicAPI {
      return _public!
   }

   public var `private`: GDAXPrivateAPI {
      return _private!
   }
   
   internal var _public: GDAXPublicAPI?
   internal var _private: GDAXPrivateAPI?
   
   init(_ config: GDAXConfig, _ baseURLString: String, _ wsURLString: String, _ decodedSecret: Data?) {
      self.config = config
      self.baseURLString = baseURLString
      self.wsURLString = wsURLString
      self.decodedSecret = decodedSecret
      
      self.ws = GDAXWebSocketFeed(client: self)
      self._private = GDAXPrivateAPI(client: self)
      self._public = GDAXPublicAPI(client: self)
   }   
}
