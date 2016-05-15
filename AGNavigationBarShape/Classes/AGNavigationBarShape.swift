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
  
  let heightShape: CGFloat = 10
  
  // Methods
  
  override public func drawRect(rect: CGRect) {
    let bezierPath: UIBezierPath = UIBezierPath()
    
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
      self.drawWave(bezierPath)
    default:
      self.drawZigzag(bezierPath)
    }
    
    // Fill Shape
    self.color.setFill()
    bezierPath.fill()
    
    // Mask to Path
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = bezierPath.CGPath
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
  func drawZigzag(bezierPath: UIBezierPath) {
    let width = self.layer.frame.width
    let height = self.layer.frame.height
    
    bezierPath.moveToPoint(CGPointMake(0, 0))
    bezierPath.addLineToPoint(CGPointMake(0, height))
    
    let cycleSizeHalf: CGFloat = (width / CGFloat(self.cycles)) / 2
    var x: CGFloat = 0
    for _ in 1...(self.cycles * 2) {
      x = x + cycleSizeHalf
      bezierPath.addLineToPoint(CGPointMake(x, height + self.heightShape))
      x = x + cycleSizeHalf
      bezierPath.addLineToPoint(CGPointMake(x, height))
    }
    bezierPath.addLineToPoint(CGPointMake(width, 0))
    bezierPath.closePath()
  }
  
  /*
   Add a Wave shape to the navigation bar
   */
  func drawWave(bezierPath: UIBezierPath) {
    let width = self.layer.frame.width
    let height = self.layer.frame.height

    bezierPath.moveToPoint(CGPointMake(0, 0))
    bezierPath.addLineToPoint(CGPointMake(0, height))

    let cycleSize = width / CGFloat(self.cycles)
    var x: CGFloat = 0
    let yc: CGFloat = height + (10 / 2)
    for i in 0..<self.cycles {
      if ((i % 2) == 0) {
        if ((i + 1) == self.cycles) {
          bezierPath.addQuadCurveToPoint(CGPointMake(x + cycleSize, height), controlPoint: CGPointMake(x + cycleSize / 2, yc + 5))
        } else {
          bezierPath.addQuadCurveToPoint(CGPointMake(x + cycleSize, yc), controlPoint: CGPointMake(x + cycleSize / 2, yc + 5))
        }
      } else {
        if ((i + 1) == self.cycles) {
          bezierPath.addQuadCurveToPoint(CGPointMake(x + cycleSize, height), controlPoint: CGPointMake(x + cycleSize / 2, yc - 5))
        } else {
          bezierPath.addQuadCurveToPoint(CGPointMake(x + cycleSize, yc), controlPoint: CGPointMake(x + cycleSize / 2, yc - 5))
        }
      }
      x += cycleSize
    }
    bezierPath.addLineToPoint(CGPointMake(width, 0))
    bezierPath.closePath()
  }
  
}
