//
//  AGNavigationBarShape.swift
//  AGNavigationBarShape
//
//  Created by Aurelien Grifasi on 14/05/16.
//  Copyright © 2016 Aurelien Grifasi. All rights reserved.
//

import UIKit

// Availables Shapes
public enum ShapeMode: Int {
	case zigzag = 0
	case wave
	case square
}

public class AGNavigationBarShape: UINavigationBar {

	@IBInspectable public var color: UIColor = UIColor(red: (251.0/255.0), green: (101.0/255), blue: (68.0/255.0), alpha: 1.0)
	@IBInspectable public var cycles: Int = 9
	@IBInspectable public var shapeMode: Int = 0 {
		didSet {
			self.shapeMode = ShapeMode(rawValue: self.shapeMode)?.rawValue ?? 0
		}
	}
	@IBInspectable public var heightShape: Int = 10 {
		didSet {
			self.heightShape = self.heightShape >= 0 ? self.heightShape : 0
		}
	}
	
	override public func draw(_ rect: CGRect) {
		let bezierPath: UIBezierPath = UIBezierPath()
		
		// Apply color on status bar
		if let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
			if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
				statusBar.backgroundColor = self.color
			}
		}
		
		// Draw Shape
		switch ShapeMode(rawValue: self.shapeMode)! {
		case .wave:
			self.drawWave(bezierPath)
		case .square:
			self.drawSquare(bezierPath)
		default:
			self.drawZigzag(bezierPath)
		}
		
		// Fill Shape
		self.color.setFill()
		bezierPath.fill()
		
		// Mask to Path
		let shapeLayer = CAShapeLayer()
		shapeLayer.path = bezierPath.cgPath
		self.layer.mask = shapeLayer

		//		Display Shape thanks to layer shadow
		self.layer.shadowPath = bezierPath.cgPath
		self.layer.shadowColor = self.color.cgColor
		self.layer.shadowOpacity = 1
		self.layer.shadowOffset = CGSize(width: 0, height: 5)
		self.layer.shouldRasterize = true
  }
	
  /*
   Add a Zigzag shape to the navigation bar
   */
  func drawZigzag(_ bezierPath: UIBezierPath) {
    let width = self.layer.frame.width
    let height = self.layer.frame.height
    
    bezierPath.move(to: CGPoint(x: 0, y: 0))
    bezierPath.addLine(to: CGPoint(x: 0, y: height))
    
    let cycleSizeHalf: CGFloat = (width / CGFloat(self.cycles)) / 2
    var x: CGFloat = 0
    for _ in 1...(self.cycles * 2) {
      x = x + cycleSizeHalf
      bezierPath.addLine(to: CGPoint(x: x, y: height + CGFloat(self.heightShape)))
      x = x + cycleSizeHalf
      bezierPath.addLine(to: CGPoint(x: x, y: height))
    }
    bezierPath.addLine(to: CGPoint(x: width, y: 0))
    bezierPath.close()
  }
  
  /*
   Add a Wave shape to the navigation bar
   */
  func drawWave(_ bezierPath: UIBezierPath) {
		let width = self.layer.frame.width
		let height = self.layer.frame.height

    // Mandatory Odd number
    if self.cycles % 2 == 0 {
      self.cycles += 1
    }

    bezierPath.move(to: CGPoint(x: 0, y: 0))
    bezierPath.addLine(to: CGPoint(x: 0, y: height))

    let cycleSize = width / CGFloat(self.cycles)
    var x: CGFloat = 0
		let arcHeight = CGFloat(self.heightShape) / 2
    let y: CGFloat = height + arcHeight
		
		for i in 0..<self.cycles {
      if (i % 2) == 0 {
				if (i + 1) == self.cycles {
					bezierPath.addQuadCurve(to: CGPoint(x: x + cycleSize, y: height), controlPoint: CGPoint(x: x + cycleSize / 2, y: y + arcHeight))
				} else {
					bezierPath.addQuadCurve(to: CGPoint(x: x + cycleSize, y: y), controlPoint: CGPoint(x: x + cycleSize / 2, y: y + arcHeight))
				}
      } else {
				bezierPath.addQuadCurve(to: CGPoint(x: x + cycleSize, y: y), controlPoint: CGPoint(x: x + cycleSize / 2, y: y - arcHeight))
      }
			x += cycleSize
		}
		bezierPath.addLine(to: CGPoint(x: width, y: 0))
    bezierPath.close()
  }
  
  /*
   Add a Square shape to the navigation bar
   */
  func drawSquare(_ bezierPath: UIBezierPath) {
    let width = self.layer.frame.width
    let height = self.layer.frame.height
    
    bezierPath.move(to: CGPoint(x: 0, y: 0))
    bezierPath.addLine(to: CGPoint(x: 0, y: height))

    let cycleSize: CGFloat = width / CGFloat(self.cycles * 2)
    let xOffset = cycleSize / 2
		var x = xOffset
		
    bezierPath.addLine(to: CGPoint(x: xOffset, y: height))
    
		for i in 0..<self.cycles {
      bezierPath.addLine(to: CGPoint(x: x, y: height + CGFloat(self.heightShape)))
      x = x + cycleSize
      bezierPath.addLine(to: CGPoint(x: x, y: height + CGFloat(self.heightShape)))
      bezierPath.addLine(to: CGPoint(x: x, y: height))
      
      if (i + 1) != self.cycles {
        x = x + cycleSize
        bezierPath.addLine(to: CGPoint(x: x, y: height))
			}
		}
		x = x + xOffset
		bezierPath.addLine(to: CGPoint(x: x, y: height))
    bezierPath.addLine(to: CGPoint(x: width, y: 0))
    bezierPath.close()
  }
}
