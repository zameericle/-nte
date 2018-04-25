//
//  AnteRepository.swift
//  Ante
//
//  Created by Zameer Andani on 4/6/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

protocol AnteRepository {
   var source: AnteDataSource {
      get
   }
   
   func fetchAllAccounts(completion: @escaping ([AnteAccount]?, Error?) -> Void)
}
