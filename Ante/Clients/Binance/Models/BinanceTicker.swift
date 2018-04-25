//
//  BinanceTicker.swift
//  Ante
//
//  Created by Zameer Andani on 4/17/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation


struct BinanceTicker: AnteTicker {
   struct BinanceTickerImpl: Decodable {
      let e: String
      let E: Int
      let s: String
      let p: String
      let P: String
      let w: String
      let x: String
      let c: String
      let Q: String
      let b: String
      let B: String
      let a: String
      let A: String
      let o: String
      let h: String
      let l: String
      let v: String
      let q: String
      let O: Int64
      let C: Int64
      let F: Int64
      let L: Int64
      let n: Int64

      enum CodingKeys: String, CodingKey {
         case e
         case E
         case s
         case p
         case P
         case w
         case x
         case c
         case Q
         case b
         case B
         case a
         case A
         case o
         case h
         case l
         case v
         case q
         case O
         case C
         case F
         case L
         case n
      }
   }
   
   let data: BinanceTickerImpl
   let source: AnteDataSource = .binance
   
   var type: String {
      get {
         return ""
      }
   }
   
   var sequence: Int64 {
      get {
         return Int64(data.E)
      }
   }
   
   var productId: String  {
      get {
         return data.s
      }
   }
   
   var price: Double  {
      get {
         return Double(data.b)!
      }
   }
   var open24h: Double {
      get {
         return Double(data.o)!
      }
   }
      
   var volume24h: Double {
      get {
         return -1
      }
   }
   
   var low24h: Double {
      get {
         return Double(data.l)!
      }
   }
   
   var high24h: Double {
      get {
         return Double(data.h)!
      }
   }
   
   var volume30d: Double {
      get {
         return -1
      }
   }
   
   var bestBid: Double {
      get {
         return Double(data.b)!
      }
   }
   
   var bestAsk: Double {
      get {
         return Double(data.a)!
      }
   }
   
   var side: String? {
      get {
         return ""
      }
   }
   
   var time: Date? {
      get {
         return Date(milliseconds: data.E)
      }
   }
   
   var tradeId: Int64? {
      get {
         return data.L
      }
   }
   
   var lastSize: Double? {
      get {
         return Double(data.q)!
      }
   }
   
   enum CodingKeys: String, CodingKey {
      case data
   }
}
