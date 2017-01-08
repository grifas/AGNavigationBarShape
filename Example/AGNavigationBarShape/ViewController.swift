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
    self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    
    self.zigzagButton.addTarget(self, action: #selector(self.displayViewControllerWithZigzagNavigationBar), for: .touchUpInside)
    self.waveButton.addTarget(self, action: #selector(self.displayViewControllerWithWaveNavigationBar), for: .touchUpInside)
    self.squareButton.addTarget(self, action: #selector(self.displayViewControllerWithSquareNavigationBar), for: .touchUpInside)
  }
  
  func displayViewControllerWithZigzagNavigationBar() {
    (self.navigationController!.navigationBar as! AGNavigationBarShape).mode = .zigzag
    (self.navigationController!.navigationBar as! AGNavigationBarShape).color = UIColor.red
    (self.navigationController!.navigationBar as! AGNavigationBarShape).cycles = Int(self.cyclesTexField.text!)!
    (self.navigationController!.navigationBar as! AGNavigationBarShape).layoutSubviews()
  }

  func displayViewControllerWithWaveNavigationBar() {
    (self.navigationController!.navigationBar as! AGNavigationBarShape).mode = .wave
    (self.navigationController!.navigationBar as! AGNavigationBarShape).color = UIColor.orange
    (self.navigationController!.navigationBar as! AGNavigationBarShape).cycles = Int(self.cyclesTexField.text!)!
    (self.navigationController!.navigationBar as! AGNavigationBarShape).layoutSubviews()
  }

  func displayViewControllerWithSquareNavigationBar() {
    (self.navigationController!.navigationBar as! AGNavigationBarShape).mode = .square
    (self.navigationController!.navigationBar as! AGNavigationBarShape).color = UIColor.purple
    (self.navigationController!.navigationBar as! AGNavigationBarShape).cycles = Int(self.cyclesTexField.text!)!
    (self.navigationController!.navigationBar as! AGNavigationBarShape).layoutSubviews()
  }
  
}
