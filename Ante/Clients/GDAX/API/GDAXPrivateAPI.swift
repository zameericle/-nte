//
//  GDAXPrivateAPI.swift
//  Ante
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation
import CryptoSwift

// defines the private APIs (authorization required) accessible through GDAX
class GDAXPrivateAPI: GDAXAPI {   
   override init(client: GDAXClient) {
      super.init(client: client)
      
      super.httpClient.requestMiddleware += [
         { request in
            
            // https://docs.gdax.com/#generating-an-api-key
            var req = request
            
            guard let httpMethod = req.httpMethod else { return req }
            guard let urlPath = req.url?.path else { return req }
            let timestamp = "\(Int64(Date().timeIntervalSince1970))"
            
            var what = timestamp + httpMethod + urlPath
            
            if let body = req.httpBody {
               what += String(data: body, encoding: .utf8)!
            }

            guard let prehash = what.data(using: .utf8) else {
               throw AnteHTTPClientError.ConfigError("Unable to create prehash string")
            }
            
            guard let decodedSecret = super.client.decodedSecret else {
               throw AnteHTTPClientError.ConfigError("Decoded secret not set")
            }
            
            guard let hmac = try HMAC(key: (decodedSecret.bytes), variant: .sha256).authenticate(prehash.bytes).toBase64() else {
               throw AnteHTTPClientError.ConfigError("Unable to generate HMAC signature")
            }
            
            req.addValue(super.client.config.key, forHTTPHeaderField: "CB-ACCESS-KEY")
            req.addValue(super.client.config.passphrase!, forHTTPHeaderField: "CB-ACCESS-PASSPHRASE")
            req.addValue(timestamp, forHTTPHeaderField: "CB-ACCESS-TIMESTAMP")
            req.addValue(hmac, forHTTPHeaderField: "CB-ACCESS-SIGN")
            
            return req
         },
      ]
   }
   
   func accounts(completion: @escaping (Result<[GDAXAccount]>) -> Void) {
      //method: GET
      //url: /accounts
      super.httpClient.requestJson(
         urlString: "/accounts",
         method: .GET,
         completion: completion)
   }
}
