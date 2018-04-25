//
//  KeyManager.swift
//  Ante
//
//  Created by Zameer Andani on 3/23/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation
import Keys

struct BinanceConfig {
   let key: String
   let secret: String
   let passphrase: String? = ""
}

struct GDAXConfig {
   let key: String
   let secret: String
   let passphrase: String?
}

struct KeyManager {
   static func binanceInfo() -> BinanceConfig {
      return BinanceConfig(key: AnteKeys().binanceAPIKey, secret: AnteKeys().binanceSecretKey)
   }
   
   static func gdaxInfo() -> GDAXConfig {
      return GDAXConfig(key: AnteKeys().gDAXAPIKey, secret: AnteKeys().gDAXSecretKey, passphrase: AnteKeys().gDAXPassphrase)
   }
}
