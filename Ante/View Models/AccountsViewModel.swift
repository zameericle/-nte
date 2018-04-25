//
//  AccountsViewModel.swift
//  Ante
//
//  Created by Zameer Andani on 3/23/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

protocol AccountsViewModelDelegate {
   func onInsert(models: [AccountViewModel])
   func onUpdate(models: [AccountViewModel])
}

class AccountsSummaryVM {
   private var _portfolioTotal: Double
   private var _gainLoss: Double
   
   var portfolioTotal: String {
      return "\(self._portfolioTotal.withCommasAsCurrency(2))"
   }
   
   var gainLoss: String {
      return "\(self._gainLoss.withCommasAsCurrency(2))"
   }
   
   var _gainLossPct: Double {
      return ((self._portfolioTotal - 57581.16)/57581.16)
   }
   
   var gainLossPct: String {
      let value = self._gainLossPct.roundTo(places: 2)
      var suffix = "-"
      if (value > 0) {
         suffix = "▲"
      }
      else if (value < 0) {
         suffix = "▼"
      }
      
      return "\(value.withCommasAsPercent(2)) \(suffix)"
   }
   
   init(_ portfolioTotal: Double) {
      self._portfolioTotal = portfolioTotal
      self._gainLoss = _portfolioTotal - 57581.16
   }
}

class AccountsViewModel {

   internal var model: AccountsModel
   internal var delegate: AccountsViewModelDelegate?
   
   internal var accountSummary: AccountsSummaryVM {
      get {
         var portfolioTotal = 0.00
         self.forEach { account in
            if account._balance > 1.00 {
               if let value = account._value {
                  portfolioTotal += value
               }
            }
         }
         return AccountsSummaryVM(portfolioTotal)
      }
   }
   
   init(_ model: AccountsModel) {
      self.model = model
      
      self.model.addObserver { modelUpdateInfo in
         
         switch modelUpdateInfo {
         case .INSERTIONS(let accounts):
            let accountsVM = accounts.map{ account in
               return AccountViewModel(account)
            }
            
            self.delegate?.onInsert(models: accountsVM)
            
         case .UPDATES(let accounts):
            let accountsVM = accounts.map{ account in
               return AccountViewModel(account)
            }
            
            self.delegate?.onUpdate(models: accountsVM)

         default:
            print("here")
         }
      }
   }
}

typealias AccountsViewModelCollection = AccountsViewModel
extension AccountsViewModelCollection: Collection {
   typealias Index = Int
   typealias Element = AccountViewModel
   
   var startIndex: Index { return self.model.startIndex }
   var endIndex: Index { return self.model.endIndex }
   
   subscript(index: Index) -> Element {
      get {
        return AccountViewModel(self.model[index])
      }
   }
   
   func index(after i: Int) -> Int {
      return (i + 1)
   }
}



