//
//  AnteCell.swift
//  Ante
//
//  Created by Zameer Andani on 3/3/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import UIKit

class AnteCell: UITableViewCell {
   var model: AccountViewModel!
   
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
      self.backgroundColor = AppColors.KryptoCellBackgroundColor
      self.currencyLabel.text = self.model.currency
      self.coinValueLabel.text = self.model.value
      self.accountBalanceLabel.text = self.model.balance
      self.priceLabel.text = self.model.price
      self.gainLossLabel.text = self.model.gainLoss
      self.sourceLabel.text = "\(self.model.source)".uppercased()
   }
}

