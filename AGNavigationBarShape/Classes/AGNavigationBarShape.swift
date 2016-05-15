//
//  AGNavigationBarShape.swift
//  AGNavigationBarShape
//
//  Created by Aurelien Grifasi on 14/05/16.
//  Copyright © 2016 aurelien.grifasi. All rights reserved.
//

import UIKit

public class AGNavigationBarShape: UINavigationBar {
  
  // Availables Shapes
  public enum ShapeMode: Int {
    case Wave = 0
    case Zigzag
  }
  
  public var mode: ShapeMode = ShapeMode.Wave
  
  @IBInspectable public var color: UIColor = UIColor(red: (251.0/255.0), green: (101.0/255), blue: (68.0/255.0), alpha: 1.0)
  @IBInspectable public var cycles: Int = 9
  @IBInspectable var shapeMode: Int {
    get {
      return self.mode.rawValue
    }
    set(shapeIndex) {
      self.mode = ShapeMode(rawValue: shapeIndex) ?? .Zigzag
    }
  }
  
  let bezierPath: UIBezierPath = UIBezierPath()
  let heightShape: CGFloat = 10
  
  // Methods
  
  override public func drawRect(rect: CGRect) {
    
    // Apply color on status bar
    if let statusBar: UIView = UIApplication.sharedApplication().valueForKey("statusBar") as? UIView {
      if statusBar.respondsToSelector(Selector("setBackgroundColor:")) {
        statusBar.backgroundColor = self.color
      }
    }
    
    // Mandatory Odd number
    if self.cycles % 2 == 0 {
      self.cycles += 1
    }
    
    // Draw Shape
    switch self.mode {
    case .Wave:
      self.drawWave()
    default:
      self.drawZigzag()
    }
    
    // Fill Shape
    self.color.setFill()
    self.bezierPath.fill()
    
    // Mask to Path
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = self.bezierPath.CGPath
    self.layer.mask = shapeLayer
    
    // Display Shape thanks to layer shadow
    self.layer.shadowColor = self.color.CGColor
    self.layer.shadowOffset = CGSizeMake(0.0, self.heightShape)
    self.layer.shadowOpacity = 1
    self.layer.shouldRasterize = true
  }
  
  /*
   Add a Zigzag shape to the navigation bar
   */
  func drawZigzag() {
    let width = self.layer.frame.width
    let height = self.layer.frame.height
    
    self.bezierPath.moveToPoint(CGPointMake(0, 0))
    self.bezierPath.addLineToPoint(CGPointMake(0, height))
    
    let cycleSizeHalf: CGFloat = (width / CGFloat(self.cycles)) / 2
    var x: CGFloat = 0
    for _ in 1...(self.cycles * 2) {
      x = x + cycleSizeHalf
      self.bezierPath.addLineToPoint(CGPointMake(x, height + self.heightShape))
      x = x + cycleSizeHalf
      self.bezierPath.addLineToPoint(CGPointMake(x, height))
    }
    self.bezierPath.addLineToPoint(CGPointMake(width, 0))
    self.bezierPath.closePath()
  }
  
  /*
   Add a Wave shape to the navigation bar
   */
  func drawWave() {
    let width = self.layer.frame.width
    let height = self.layer.frame.height

    self.bezierPath.moveToPoint(CGPointMake(0, 0))
    self.bezierPath.addLineToPoint(CGPointMake(0, height))

    let cycleSize = width / CGFloat(self.cycles)
    var x: CGFloat = 0
    let yc: CGFloat = height + (10 / 2)
    for i in 0..<self.cycles {
      if ((i % 2) == 0) {
        if ((i + 1) == self.cycles) {
          self.bezierPath.addQuadCurveToPoint(CGPointMake(x + cycleSize, height), controlPoint: CGPointMake(x + cycleSize / 2, yc + 5))
        } else {
          self.bezierPath.addQuadCurveToPoint(CGPointMake(x + cycleSize, yc), controlPoint: CGPointMake(x + cycleSize / 2, yc + 5))
        }
      } else {
        if ((i + 1) == self.cycles) {
          self.bezierPath.addQuadCurveToPoint(CGPointMake(x + cycleSize, height), controlPoint: CGPointMake(x + cycleSize / 2, yc - 5))
        } else {
          self.bezierPath.addQuadCurveToPoint(CGPointMake(x + cycleSize, yc), controlPoint: CGPointMake(x + cycleSize / 2, yc - 5))
        }
      }
      x += cycleSize
    }
    self.bezierPath.addLineToPoint(CGPointMake(width, 0))
    self.bezierPath.closePath()
  }
  
}
