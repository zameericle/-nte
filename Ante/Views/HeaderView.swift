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
   @IBOutlet weak var portfolioValueLabel: UILabel!
}

class GainLossView: UIView {
   @IBOutlet weak var gainLossValueLabel: UILabel!
   @IBOutlet weak var gainLossPctLabel: UILabel!
}

class HeaderView: UIView {

   var accountSummary: AccountsSummaryVM? {
      didSet {
         self.portfolioView.portfolioValueLabel.text = "\(self.accountSummary!.portfolioTotal)"
         self.gainLossView.gainLossValueLabel.text = "\(self.accountSummary!.gainLoss)"
         self.gainLossView.gainLossPctLabel.text = "\(self.accountSummary!.gainLossPct)"
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
      self.portfolioView.portfolioValueLabel.text = "loading"
      self.gainLossView.gainLossValueLabel.text = "loading"
   }
}

