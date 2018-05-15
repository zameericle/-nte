//
//  AnteCell.swift
//  Ante
//
//  Created by Zameer Andani on 3/3/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import UIKit

class AnteCell: UITableViewCell {
   var model: AccountViewModel?
   
   @IBOutlet weak var currencyLabel: UILabel!   
   @IBOutlet weak var coinValueLabel: UILabel!
   @IBOutlet weak var accountBalanceLabel: UILabel!
   @IBOutlet weak var priceLabel: UILabel!
   @IBOutlet weak var gainLossLabel: UILabel!
   @IBOutlet weak var sourceLabel: UILabel!
   
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      self.backgroundColor = AppColors.AnteCellBackgroundColor
      self.currencyLabel.textColor = AppColors.AnteCellCurrencyLabelTextColor
      self.coinValueLabel.textColor = AppColors.AnteCellCoinValueTextColor
      self.accountBalanceLabel.textColor = AppColors.AnteCellAccountBalanceTextColor
      self.priceLabel.textColor = AppColors.AnteCellPriceLabelTextColor
      self.gainLossLabel.textColor = AppColors.AnteCellGainLossTextColor
      self.sourceLabel.textColor = AppColors.AnteCellSourceTextColor
      
      if let model = self.model {
         self.currencyLabel.text = model.currency
         self.coinValueLabel.text = model.value
         self.accountBalanceLabel.text = model.balance
         self.priceLabel.text = model.price
         self.gainLossLabel.text = model.gainLoss
         
         if (self.gainLossLabel.text?.contains("▼"))! {
            self.gainLossLabel.textColor = AppColors.NegativeTextColor
         } else {
            self.gainLossLabel.textColor = AppColors.PositiveTextColor
         }

         self.sourceLabel.text = "\(model.source)".uppercased()
      }
   }
}

