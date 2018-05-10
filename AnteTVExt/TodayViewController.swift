//
//  TodayViewController.swift
//  AnteTVExt
//
//  Created by Zameer Andani on 4/28/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
   
   @IBOutlet weak var tableView: UITableView!
   var accountsVM: AccountsViewModel?
   private var tableData: [AccountViewModel] {
      get {
         let filteredData = self.accountsVM?.filter { account in
            return account._balance > 1.00 ? true : false
         }
         
         return filteredData!.sorted { $0.currency < $1.currency }
      }
   }
   
   override func viewDidLoad() {
      // Do any additional setup after loading the view from its nib.
      super.viewDidLoad()
      self.tableView.dataSource = self
      self.extensionContext?.widgetLargestAvailableDisplayMode = .expanded
      self.accountsVM = AccountsViewModel(AppManager.sharedInstance.accountsModel)
      self.accountsVM!.delegate = self
      AppManager.sharedInstance.refresh { model, err in
         NSLog("accounts: \(model.count)")
         if let err = err {
            //TODO: handle error
            err.forEach { err in
               NSLog(err.localizedDescription)
            }
         }
      }

   }
    
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
    
   func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
      // Perform any setup necessary in order to update the view.

      // If an error is encountered, use NCUpdateResult.Failed
      // If there's no update required, use NCUpdateResult.NoData
      // If there's an update, use NCUpdateResult.NewData
   }
   
   func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
      if (activeDisplayMode == .compact){
         // Changed to compact mode
         self.preferredContentSize = maxSize;
      } else{
         self.preferredContentSize = CGSize(width: self.tableView.contentSize.width, height: self.tableView.contentSize.height + 25);
      }
   }
   
   private func updateUI(callback: @escaping () -> ()) {
      DispatchQueue.global().async(execute: {
         DispatchQueue.main.sync {
            callback()
         }
      })
   }
    
}

typealias TodayViewControllerUITableViewDataSource = TodayViewController
extension TodayViewControllerUITableViewDataSource: UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return self.tableData.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: AnteCell = (self.tableView.dequeueReusableCell(withIdentifier: "AnteCell") as? AnteCell)!
      cell.layoutMargins = UIEdgeInsets.zero
      
      let account = self.tableData[indexPath.row]
      cell.model = account
      
      return cell
   }
}

typealias TodayViewControllerAccountsViewModelDelegate = TodayViewController
extension TodayViewControllerAccountsViewModelDelegate: AccountsViewModelDelegate {
   func onInsert(models: [AccountViewModel]) {
      self.updateUI {
         self.tableView.reloadSections([0], with: .fade)
      }
   }
   
   func onUpdate(models: [AccountViewModel]) {
      self.updateUI {
         let indexPaths = self.tableView.visibleCells.filter { cell in
            let cell = cell as! AnteCell
            return cell.model!.id == models[0].id
            }.map { cell in
               return self.tableView.indexPath(for: cell)!
         }
         
         self.tableView.reloadRows(at: indexPaths, with: .none)
      }
   }
}
//
