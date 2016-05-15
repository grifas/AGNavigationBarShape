//
//  TableViewController.swift
//  AGNavigationBarShape
//
//  Created by Aurelien Grifasi on 15/05/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "AGNavigationBarShape"
    self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
     self.navigationItem.rightBarButtonItem = self.editButtonItem()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
