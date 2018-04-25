//
//  GDAXAPIError.swift
//  Ante
//
//  Created by Zameer Andani on 3/18/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

struct GDAXAPIError: AnteAPIError {
   let source: AnteDataSource = .gdax
   
   let message: String
   
   enum CodingKeys: String, CodingKey {
      case message
   }
}
