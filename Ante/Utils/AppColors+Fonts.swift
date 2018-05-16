//
//  AnteColors.swift
//  Ante
//
//  Created by Zameer Andani on 3/3/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import UIKit

class AppColors {
   // Primary Constants
   static let primaryColor = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1.0);
   static let primaryLightColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.0);
   static let primaryDarkColor = UIColor(red: 0.73, green: 0.74, blue: 0.75, alpha: 1.0);
   static let primaryTextColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 1.0);

   // Actual Elements
   static let AppBackgroundColor = primaryDarkColor
   
   static let HeaderBackgroundColor = primaryColor
   static let HeaderTitleTextColor = primaryTextColor
   static let HeaderTextColor = primaryTextColor
   
   static let TableViewBackgroundColor = primaryDarkColor
   static let AnteCellBackgroundColor = primaryLightColor
   static let AnteCellBorderColor = primaryDarkColor
   static let AnteCellCurrencyLabelTextColor = primaryTextColor
   static let AnteCellCoinValueTextColor = primaryDarkColor
   static let AnteCellAccountBalanceTextColor = primaryTextColor
   static let AnteCellPriceLabelTextColor = primaryTextColor
   static let AnteCellGainLossTextColor = primaryTextColor
   static let AnteCellSourceTextColor = primaryTextColor
   
   // Text 
   static let PositiveTextColor = primaryTextColor
   static let NegativeTextColor = primaryTextColor
}
