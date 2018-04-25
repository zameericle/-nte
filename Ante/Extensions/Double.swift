//
//  Double.swift
//  Ante
//
//  Created by Zameer Andani on 3/23/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

extension Double {
   func roundTo(places:Int) -> Double {
      let divisor = pow(10.0, Double(places))
      return (self * divisor).rounded() / divisor
   }
   
   func withCommas(_ fractionDigits: Int) -> String {
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = NumberFormatter.Style.decimal
      numberFormatter.generatesDecimalNumbers = true
      numberFormatter.maximumFractionDigits = fractionDigits
      numberFormatter.minimumFractionDigits = fractionDigits
      numberFormatter.roundingMode = .up
      
      return numberFormatter.string(from: NSNumber(value: self))!
   }
}
