//
//  BinanceAPI.swift
//  Ante
//
//  Created by Zameer Andani on 3/31/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

class BinanceAPI {
   
   internal let httpClient: AnteHTTPClient!
   internal let client: BinanceClient!
   
   init(client: BinanceClient) {
      self.client = client
      self.httpClient = AnteHTTPClient().baseUrl(client.baseURLString)
      self.httpClient.responseHandler = self
   }
}

private typealias BinanceAPIResponseHandler = BinanceAPI
extension BinanceAPIResponseHandler: AnteHTTPResponseHandler {
   func handleResponse<T>(response: HTTPURLResponse, data: Data, next: (HTTPURLResponse, Data) -> Result<T>) -> Result<T> where T : Decodable {
      if case 200 ... 299 = response.statusCode  {
         return next(response, data)
      }
      
      do {
         let decoder = JSONDecoder()
         decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
         
         let apiError: BinanceAPIError = try decoder.decode(BinanceAPIError.self, from: data)
         return .Failure(.APIError(apiError.message))
      } catch let error {
         return .Failure(.APIError(error.localizedDescription))
      }
   }
}


