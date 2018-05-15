//
//  HeaderView.swift
//  Ante
//
//  Created by Zameer Andani on 3/3/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation
import UIKit

class PortfolioView: UIView {
   @IBOutlet weak var balanceTitleLabel: UILabel!
   @IBOutlet weak var balanceAmtLabel: UILabel!
}

class GainLossView: UIView {
   @IBOutlet weak var gainLossTitleLabel: UILabel!
   @IBOutlet weak var gainLossValueLabel: UILabel!
   @IBOutlet weak var gainLossPctLabel: UILabel!
}

class HeaderView: UIView {

   var accountSummary: AccountsSummaryVM? {
      didSet {
         self.portfolioView.balanceAmtLabel.text = "\(self.accountSummary!.portfolioTotal)"
         self.gainLossView.gainLossValueLabel.text = "\(self.accountSummary!.gainLoss)"
         self.gainLossView.gainLossPctLabel.text = "\(self.accountSummary!.gainLossPct)"
         
////         if (self.gainLossView.gainLossValueLabel.text?.contains("-"))! {
////            self.gainLossView.gainLossValueLabel.textColor = AppColors.NegativeTextColor
////         } else {
////            self.gainLossView.gainLossValueLabel.textColor = AppColors.PositiveTextColor
////         }
////
////         if (self.gainLossView.gainLossPctLabel.text?.contains("▼"))! {
////            self.gainLossView.gainLossPctLabel.textColor = AppColors.NegativeTextColor
////         } else {
////            self.gainLossView.gainLossPctLabel.textColor = AppColors.PositiveTextColor
////         }
      }
   }
   @IBOutlet weak var portfolioView: PortfolioView!
   @IBOutlet weak var gainLossView: GainLossView!
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      self.backgroundColor = AppColors.HeaderBackgroundColor
      self.portfolioView.balanceTitleLabel.textColor = AppColors.HeaderTitleTextColor
      self.gainLossView.gainLossTitleLabel.textColor = AppColors.HeaderTitleTextColor
      self.portfolioView.balanceAmtLabel.textColor = AppColors.HeaderTextColor
      self.gainLossView.gainLossValueLabel.textColor = AppColors.HeaderTextColor
      self.gainLossView.gainLossPctLabel.textColor = AppColors.HeaderTextColor
      
      self.portfolioView.balanceAmtLabel.text = "$--.--"
      self.gainLossView.gainLossValueLabel.text = "--.--"
   }
}

