//
//  GDAXPublicAPI.swift
//  Ante
//
//  Created by Zameer Andani on 3/11/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

// defines the public APIs (no authorization needed) accessible through GDAX
class GDAXPublicAPI: GDAXAPI {
   override init(client: GDAXClient) {
      super.init(client: client)
   }

   //https://docs.gdax.com/#time
   func time(completion: @escaping (Result<GDAXTime>) -> Void) {
      super.httpClient.requestJson(
         urlString: "/time",
         method: .GET,
         completion: completion)
   }
   
   //https://docs.gdax.com/#get-currencies
   func currencies(completion: @escaping (Result<[GDAXCurrency]>) -> Void) {
      super.httpClient.requestJson(
         urlString: "/currencies",
         method: .GET,
         completion: completion)
   }
}

private typealias GDAXProductAPI = GDAXPublicAPI
extension GDAXProductAPI {
   // Product API
   enum GDAXGranularity: String {
      case sixty = "60"
      case threeHundred = "300"
      case nineHundred = "900"
      case threeThousandSixHundred = "3600"
      case twentyOneThousandSixHundred = "21600"
      case eightySixThousandFourHundred = "86400"
   }

   
   //https://docs.gdax.com/#get-products
   func products(completion: @escaping (Result<[GDAXProduct]>) -> Void) {
      super.httpClient.requestJson(
         urlString: "/products",
         method: .GET,
         completion: completion)
   }
   
   //https://docs.gdax.com/#get-product-order-book
   func orderBook(forProduct productId: String, level: String?, completion: @escaping (Result<GDAXProductOrderBook>) -> Void) {
      
      super.httpClient.requestJson(
         urlString: "/products/\(productId)/book",
         queryItems: [URLQueryItem(name: "level", value: level)],
         method: .GET,
         completion: completion)
   }
   
   //https://docs.gdax.com/#get-product-ticker
   func ticker(forProduct productId: String, completion: @escaping (Result<GDAXProductTick>) -> Void) {
      
      super.httpClient.requestJson(
         urlString: "/products/\(productId)/ticker",
         method: .GET,
         completion: completion)
   }
   
   //https://docs.gdax.com/#get-trades
   func trades(forProduct productId: String, completion: @escaping (Result<[GDAXProductTrade]>) -> Void) {
      
      super.httpClient.requestJson(
         urlString: "/products/\(productId)/trades",
         method: .GET,
         completion: completion)
   }
   
   //https://docs.gdax.com/#get-historic-rates
   func historicRates(forProduct productId: String, start: Date?, end: Date?, granularity: GDAXGranularity, completion: @escaping (Result<[GDAXHistoricRate]>) -> Void) {
      
      var startDateStr = ""
      var endDateStr = ""
      
      if let startDate = start {
         startDateStr = DateFormatter.iso8601Full.string(from: startDate)
      }
      
      if let endDate = end {
         endDateStr = DateFormatter.iso8601Full.string(from: endDate)
      }
      
      let queryItems = [
         URLQueryItem(name: "start", value: startDateStr),
         URLQueryItem(name: "end", value: endDateStr),
         URLQueryItem(name: "granularity", value: granularity.rawValue)
      ]
      
      super.httpClient.requestJson(
         urlString: "/products/\(productId)/candles",
         queryItems: queryItems,
         method: .GET,
         completion: completion)
   }
   
   //https://docs.gdax.com/#get-24hr-stats
   func dailyStats(forProduct productId: String, completion: @escaping (Result<GDAXProductDailyStat>) -> Void) {
      
      super.httpClient.requestJson(
         urlString: "/products/\(productId)/stats",
         method: .GET,
         completion: completion)
   }
}
