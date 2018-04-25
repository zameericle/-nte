//
//  Date.swift
//  Ante
//
//  Created by Zameer Andani on 3/31/18.
//  Copyright © 2018 shabash. All rights reserved.
//
//  From: https://stackoverflow.com/questions/40134323/date-to-milliseconds-and-back-to-date-in-swift

import Foundation

extension Date {
   var millisecondsSince1970:Int64 {
      return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
   }
   
   init(milliseconds:Int) {
      self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
   }
}
