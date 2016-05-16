//
//  ViewController.swift
//  AGNavigationBarShape
//
//  Created by Aurelien Grifasi on 15/05/16.
//  Copyright © 2016 Aurelien Grifasi. All rights reserved.
//

import UIKit
import AGNavigationBarShape

class ViewController: UIViewController {
  
  @IBOutlet weak var zigzagButton: UIButton!
  @IBOutlet weak var waveButton: UIButton!
  @IBOutlet weak var squareButton: UIButton!
  @IBOutlet weak var cyclesTexField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "AGNavigationBarShape"
    self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    
    self.zigzagButton.addTarget(self, action: #selector(self.displayViewControllerWithZigzagNavigationBar), forControlEvents: UIControlEvents.TouchUpInside)
    self.waveButton.addTarget(self, action: #selector(self.displayViewControllerWithWaveNavigationBar), forControlEvents: UIControlEvents.TouchUpInside)
    self.squareButton.addTarget(self, action: #selector(self.displayViewControllerWithSquareNavigationBar), forControlEvents: UIControlEvents.TouchUpInside)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func displayViewControllerWithZigzagNavigationBar() {
    (self.navigationController!.navigationBar as! AGNavigationBarShape).mode = .Zigzag
    (self.navigationController!.navigationBar as! AGNavigationBarShape).color = UIColor.redColor()
    (self.navigationController!.navigationBar as! AGNavigationBarShape).cycles = Int(self.cyclesTexField.text!)!
    (self.navigationController!.navigationBar as! AGNavigationBarShape).layoutSubviews()
  }

  func displayViewControllerWithWaveNavigationBar() {
    (self.navigationController!.navigationBar as! AGNavigationBarShape).mode = .Wave
    (self.navigationController!.navigationBar as! AGNavigationBarShape).color = UIColor.orangeColor()
    (self.navigationController!.navigationBar as! AGNavigationBarShape).cycles = Int(self.cyclesTexField.text!)!
    (self.navigationController!.navigationBar as! AGNavigationBarShape).layoutSubviews()
  }

  func displayViewControllerWithSquareNavigationBar() {
    (self.navigationController!.navigationBar as! AGNavigationBarShape).mode = .Square
    (self.navigationController!.navigationBar as! AGNavigationBarShape).color = UIColor.purpleColor()
    (self.navigationController!.navigationBar as! AGNavigationBarShape).cycles = Int(self.cyclesTexField.text!)!
    (self.navigationController!.navigationBar as! AGNavigationBarShape).layoutSubviews()
  }
  
}
