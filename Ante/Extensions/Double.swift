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
   
   public func withCommasAsCurrency(_ fractionDigits: Int) -> String {
      return self.withCommas(fractionDigits, NumberFormatter.Style.currency)
   }

   public func withCommasAsPercent(_ fractionDigits: Int) -> String {
      return self.withCommas(fractionDigits, NumberFormatter.Style.percent)
   }

   public func withCommas(_ fractionDigits: Int, _ style: NumberFormatter.Style) -> String {
      let numberFormatter = NumberFormatter()
      numberFormatter.numberStyle = style
      numberFormatter.generatesDecimalNumbers = true
      numberFormatter.maximumFractionDigits = fractionDigits
      numberFormatter.minimumFractionDigits = fractionDigits
      numberFormatter.locale = Locale(identifier: "en_US")
      numberFormatter.roundingMode = .up
      return numberFormatter.string(from: NSNumber(value: self))!
   }
}
