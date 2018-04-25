//
//  BinancePrivateAPI.swift
//  Ante
//
//  Created by Zameer Andani on 3/31/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation
import CryptoSwift

class BinancePrivateAPI: BinanceAPI {
   override init(client: BinanceClient) {
      super.init(client: client)
      
      super.httpClient.requestMiddleware += [ { request in
   
         // https://github.com/binance-exchange/binance-official-api-docs/blob/master/rest-api.md
         let timestamp = Date().millisecondsSince1970
         if let url = request.url {
            var what = ""
            var queryStr = ""
            if let query = url.query {
               queryStr = query + "&timestamp=\(timestamp)"
            } else {
               queryStr = "timestamp=\(timestamp)"
            }

            what = queryStr
            
            if let body = request.httpBody {
               what += String(data: body, encoding: .utf8)!
            }

            let signature = try HMAC(key: client.config.secret, variant: .sha256).authenticate(what.bytes).toHexString()
            
            let url = URL(string: "\(request.url!)?timestamp=\(timestamp)&signature=\(signature)")!
            var updatedRequest = URLRequest(url: url)
            updatedRequest.httpMethod = request.httpMethod
            updatedRequest.addValue(self.client.config.key, forHTTPHeaderField: "X-MBX-APIKEY")
            
            return updatedRequest
         } else {
            return request
         }
      },]
   }

   func accounts(completion: @escaping (Result<BinanceAccounts>) -> Void) {
      //method: GET
      //url: /api/v3/account

      super.httpClient.requestJson(
         urlString: "/api/v3/account",
         method: .GET,
         completion: completion)
   }
}
