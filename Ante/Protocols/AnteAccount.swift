//
//  AnteAccount.swift
//  Ante
//
//  Created by Zameer Andani on 3/23/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

protocol AnteAccount: AnteModel {
   var id: String { get }
   var currency: String { get }
   var balance: Double { get }
   var available: Double { get }
   var hold: Double { get }
   var lastTick: AnteTicker? { get set }
   func currencyPair(_ targetCurrency: String) -> String
}
