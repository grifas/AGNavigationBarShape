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
  
	@IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var cyclesTexField: UITextField!
	@IBOutlet weak var slider: UISlider!
	
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "AGNavigationBarShape"
		self.slider.minimumValue = 0
		self.slider.maximumValue = 100
		self.slider.value = 10
  }
	
	@IBAction func actionSlider(sender: UISlider) {
		let value = CGFloat(sender.value)
		
		(self.navigationController?.navigationBar as? AGNavigationBarShape)?.heightShape = value
		(self.navigationController?.navigationBar as? AGNavigationBarShape)?.layoutSubviews()
	}
	
	@IBAction func update(sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			self.displayViewControllerWithZigzagNavigationBar()
		case 1:
			self.displayViewControllerWithWaveNavigationBar()
		default:
			self.displayViewControllerWithSquareNavigationBar()
		}
		(self.navigationController?.navigationBar as? AGNavigationBarShape)?.cycles = Int(self.cyclesTexField.text ?? "0")!
		(self.navigationController?.navigationBar as? AGNavigationBarShape)?.layoutSubviews()
	}
	
  func displayViewControllerWithZigzagNavigationBar() {
		(self.navigationController?.navigationBar as? AGNavigationBarShape)?.mode = .zigzag
    (self.navigationController?.navigationBar as? AGNavigationBarShape)?.color = UIColor.red
  }

  func displayViewControllerWithWaveNavigationBar() {
		(self.navigationController?.navigationBar as? AGNavigationBarShape)?.mode = .wave
		(self.navigationController?.navigationBar as? AGNavigationBarShape)?.color = UIColor.orange
	}

  func displayViewControllerWithSquareNavigationBar() {
		(self.navigationController?.navigationBar as? AGNavigationBarShape)?.mode = .square
    (self.navigationController?.navigationBar as? AGNavigationBarShape)?.color = UIColor.purple
	}
  
}
