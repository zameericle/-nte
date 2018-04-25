//
//  AnteTicker.swift
//  Ante
//
//  Created by Zameer Andani on 3/28/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

protocol AnteTicker: AnteModel {
   var source: AnteDataSource { get }
   var type: String { get }
   var sequence: Int64 { get }
   var productId: String { get }
   var price: Double { get }
   var open24h: Double { get }
   var volume24h: Double { get }
   var low24h: Double { get }
   var high24h: Double { get }
   var volume30d: Double { get }
   var bestBid: Double { get }
   var bestAsk: Double { get }
   var side: String? { get }
   var time: Date? { get }
   var tradeId: Int64? { get }
   var lastSize: Double? { get }
}
