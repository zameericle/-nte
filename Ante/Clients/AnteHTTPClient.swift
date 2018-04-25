//
//  AnteHTTPClient.swift
//  Ante
//
//  Heavily inspired by: https://github.com/anthonypuppo/GDAXSwift
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

enum MethodType: String {
   case DELETE = "DELETE"
   case GET = "GET"
   case PATCH = "PATCH"
   case POST = "POST"
   case PUT = "PUT"
}

// function that takes in a request and returns a new request on which to operate on
typealias AnteHTTPRequestMiddleware = (URLRequest) throws -> URLRequest

enum AnteHTTPClientError: Error {
   case NoDataFound
   case APIError(String)
   case ConfigError(String)
}

enum Result<T> {
   case Success(T)
   case Failure(AnteHTTPClientError)
}

protocol AnteHTTPResponseHandler {
   func handleResponse<T: Decodable>(response: HTTPURLResponse, data: Data, next: (HTTPURLResponse, Data) -> Result<T>) -> Result<T>
}

class AnteHTTPClient {
   public private(set) var baseUrl: URL?
   public var responseHandler: AnteHTTPResponseHandler?
   public var requestMiddleware: Array<AnteHTTPRequestMiddleware> = Array<AnteHTTPRequestMiddleware>()
   
   init() {
   }
   
   public func baseUrl(_ baseUrlString: String) -> Self {
      self.baseUrl = URL(string: baseUrlString)
      
      return self
   }
   
   //TODO: Add Paging
   public func requestJson<T: Decodable>(urlString: String, method: MethodType, completion: @escaping (Result<T>) -> Void) {
      requestJson(urlString: urlString, queryItems: nil, method: method, completion: completion)
   }
   
   public func requestJson<T: Decodable>(urlString: String, queryItems: [URLQueryItem]?, method: MethodType, completion: @escaping (Result<T>) -> Void) {
      
      guard var component = URLComponents(url: self.baseUrl!.appendingPathComponent(urlString), resolvingAgainstBaseURL: true) else {
         completion(.Failure(.NoDataFound))
         return
      }
      
      component.queryItems = queryItems
      
      var request = URLRequest(url: component.url!)
      request.httpMethod = method.rawValue
      
      do {
         try request = executeRequestMiddleware(request)
      } catch let err {
         completion(.Failure(.ConfigError(err.localizedDescription)))
      }
      
      let dataTask = URLSession(configuration: .ephemeral).dataTask(with: request) {
         (data: Data?, response: URLResponse?, error: Error?) in
         
         // 1. handle error
         if let err = error {
            completion(.Failure(.APIError(err.localizedDescription)))
            return
         }
         
         guard let data = data else {
            completion(.Failure(.NoDataFound))
            return
         }
         
         guard let httpUrlResponse = response as! HTTPURLResponse? else {
            completion(.Failure(.NoDataFound))
            return
         }
         
         // 2. process response & data
         guard let responseHandler = self.responseHandler else {
            let res = self.processData(data) as Result<T>
            return completion(res)
         }
         
         let res = responseHandler.handleResponse(
            response: httpUrlResponse,
            data: data,
            next: {
               (response: HTTPURLResponse, data: Data) -> Result<T> in
               self.processData(data)
         })
         
         // 3. execute callback
         completion(res)
      }
      
      dataTask.resume();
   }

   private func executeRequestMiddleware(_ request: URLRequest) throws -> URLRequest  {
      var req = request
      
      do {
         for handler in requestMiddleware {
            try req = handler(req)
         }
      } catch let err {
         throw err
      }
      
      return req
   }
   
   private func processData<T: Decodable>(_ data: Data) -> Result<T> {
      // 3. process data
      do {
         let decoder = JSONDecoder()
         decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
         
         
         let decodedData: T = try decoder.decode(T.self, from: data)
         return .Success(decodedData)
      } catch let error {
         return .Failure(.APIError(error.localizedDescription))
      }
   }
}
