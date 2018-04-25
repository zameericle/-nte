//
//  AnteModel.swift
//  Ante
//
//  Created by Zameer Andani on 3/27/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

enum AnteDataSource {
   case gdax
   case binance
   case unknown
}

protocol AnteModel: Decodable {
   var source: AnteDataSource { get }
}
