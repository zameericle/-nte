//
//  AccountsModel.swift
//  Ante
//
//  Created by Zameer Andani on 4/15/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import Foundation

enum ModelUpdate {
   case INSERTIONS([AnteAccount])
   case DELETIONS([AnteAccount])
   case UPDATES([AnteAccount])
}

typealias AccountsModelObserver = (_ modelUpdate: ModelUpdate ) -> ()

class AccountsModel {
   private let dispatchQueue = DispatchQueue(label: "com.shabash.Ante.AccountsModel")
   private var models = [AnteAccount]()
   private var observers = [AccountsModelObserver]()
   
   let defaultCurrency: String
   
   init(_ defaultCurrency: String) {
      self.defaultCurrency = defaultCurrency
   }
   
   func updateModelWithTickerUpdate(_ tick: AnteTicker) {
      if let idx = self.index(where: { model in
         return model.currencyPair(self.defaultCurrency) == tick.productId
      }) {
         if let _ = self[idx].lastTick {
            if (self[idx].lastTick!.sequence < tick.sequence) {
               self[idx].lastTick = tick
               self.triggerObservers(.UPDATES([self.models[idx]]))
            }
         } else {
            self[idx].lastTick = tick
            self.triggerObservers(.UPDATES([self.models[idx]]))
         }
      }
   }
}

typealias AccountsModelObservable = AccountsModel
extension AccountsModelObservable {
   func addObserver(_ observer: @escaping AccountsModelObserver) {
      dispatchQueue.sync(flags: .barrier) {
         self.observers.append(observer)
      }
   }
   
   //TODO:to implement
   func removeObserver(_ observer: AccountsModelObserver) {}

   private func triggerObservers(_ modelUpdate: ModelUpdate) {
      dispatchQueue.async(flags: .barrier) {
         self.observers.forEach { observer in
            observer(modelUpdate)
         }
      }
   }
   
}

typealias AccountsModelCollection = AccountsModel
extension AccountsModelCollection: Collection {
   typealias Index = Int
   typealias Element = AnteAccount
   
   var startIndex: Index { return self.models.startIndex }
   var endIndex: Index { return self.models.endIndex }
   
   subscript(index: Index) -> Element {
      get {
         var model: AnteAccount?
         dispatchQueue.sync(flags: .barrier) {
            model = self.models[index]
         }
         return model!
      }
      
      set {
         dispatchQueue.sync(flags: .barrier) {
            self.models[index] = newValue
         }
      }
   }
   
   func index(after i: Int) -> Int {
      return (i + 1)
   }
   
   func append<S : Sequence>(contentsOf: S) where S.Iterator.Element == Element {
      dispatchQueue.sync(flags: .barrier) {
         self.models.append(contentsOf: contentsOf)
      }
      self.triggerObservers(.INSERTIONS(Array(contentsOf)))
   }
}
