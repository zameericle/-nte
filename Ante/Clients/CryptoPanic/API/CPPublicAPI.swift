//
//  CPPublicAPI.swift
//  Ante
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

// defines the public APIs (no authorization needed) accessible through Cyptopanic
class CPPublicAPI: CPAPI {
   override init(client: CPClient) {
      super.init(client: client)
   }
}

private typealias CPPostsAPI = CPPublicAPI
extension CPPostsAPI {
   //https://docs.gdax.com/#get-products
   func products(completion: @escaping (Result<[GDAXProduct]>) -> Void) {
      super.httpClient.requestJson(
         urlString: "/products",
         method: .GET,
         completion: completion)
   }
}
