//
//  DashboardViewController.swift
//  Ante
//
//  Created by Zameer Andani on 3/3/18.
//  Copyright © 2018 shabash. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
   @IBOutlet weak var headerView: HeaderView!
   @IBOutlet weak var tableView: UITableView!
   
   var accountsVM: AccountsViewModel?
   var loadingView: LoadingView?
   override var preferredStatusBarStyle: UIStatusBarStyle {
      return UIStatusBarStyle.default
   }
   
   internal var tableData: [AccountViewModel] {
      get {
         let filteredData = self.accountsVM?.filter { account in
            return account._balance > 1 ? true : false
         }
         
         return filteredData!.sorted { $0.currency < $1.currency }
      }
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view, typically from a nib.
      self.view.backgroundColor = AppColors.AppBackgroundColor
      self.tableView.backgroundColor = AppColors.TableViewBackgroundColor
      self.tableView.contentInset.bottom = self.tabBarController?.tabBar.frame.height ?? 0
      self.tableView.rowHeight = 125.0
      self.tableView.estimatedRowHeight = 125.0
      self.tableView.delegate = self
      self.tableView.dataSource = self
      self.accountsVM?.delegate = self
      self.loadingView = LoadingView(view: self.view)
      self.hideUI()
   }

   private func hideUI() {
      self.headerView.alpha = 0
      self.tableView.alpha = 0
      self.loadingView!.beginRefreshing()
   }
   
   private func showUI() {
      if (self.headerView.alpha == 0) {
         self.loadingView!.endRefreshing()
      
         UIView.animate(withDuration: 0.5) {
            self.headerView.alpha = 1
            self.tableView.alpha = 1
         }
      }
   }
   
   private func updateHeader() {
      self.headerView.accountSummary = self.accountsVM!.accountSummary
   }
   
   private func updateUI(callback: @escaping () -> ()) {
      DispatchQueue.global().async(execute: {
         DispatchQueue.main.sync {
            callback()
         }
      })
   }
   
   override func viewDidLayoutSubviews() {
      super.viewDidLayoutSubviews()
   }
   
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
}

typealias DashboardViewControllerAccountsViewModelDelegate = DashboardViewController
extension DashboardViewControllerAccountsViewModelDelegate: AccountsViewModelDelegate {
   func onInsert(models: [AccountViewModel]) {
      self.updateUI {
         self.tableView.reloadSections([0], with: .fade)
      }
   }
   
   func onUpdate(models: [AccountViewModel]) {
      self.updateUI {
         let indexPaths = self.tableView.visibleCells.filter { cell in
            let cell = cell as! AnteCell
            return cell.model?.id == models[0].id
            }.map { cell in
               return self.tableView.indexPath(for: cell)!
         }         

         if (indexPaths.count > 0) {
            self.tableView.reloadData()
         }
         
         self.updateHeader()
         self.showUI()
      }
   }
}

typealias DashboardViewControllerUITableViewDelegate = DashboardViewController
extension DashboardViewControllerUITableViewDelegate: UITableViewDelegate {
   
}

typealias DashboardViewControllerUITableViewDataSource = DashboardViewController
extension DashboardViewControllerUITableViewDataSource: UITableViewDataSource {
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
      
      cell.layer.borderColor = AppColors.AnteCellBorderColor.cgColor
      cell.layer.borderWidth = 1
      cell.clipsToBounds = true
      
      return cell
   }
}
