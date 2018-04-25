//
//  AnteAPIError.swift
//  Ante
//
//  Created by Zameer Andani on 3/31/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

protocol AnteAPIError: AnteModel {
   var message: String { get }
}
