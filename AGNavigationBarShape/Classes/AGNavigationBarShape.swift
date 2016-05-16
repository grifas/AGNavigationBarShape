//
//  AGNavigationBarShape.swift
//  AGNavigationBarShape
//
//  Created by Aurelien Grifasi on 14/05/16.
//  Copyright © 2016 Aurelien Grifasi. All rights reserved.
//

import UIKit

public class AGNavigationBarShape: UINavigationBar {
  
  // Availables Shapes
  public enum ShapeMode: Int {
    case Zigzag = 0
    case Wave
    case Square
  }
  
  public var mode: ShapeMode = ShapeMode.Zigzag
  let heightShape: CGFloat = 10
  
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
  
  // Methods
  
  override public func drawRect(rect: CGRect) {
    let bezierPath: UIBezierPath = UIBezierPath()
    
    // Apply color on status bar
    if let statusBar: UIView = UIApplication.sharedApplication().valueForKey("statusBar") as? UIView {
      if statusBar.respondsToSelector(Selector("setBackgroundColor:")) {
        statusBar.backgroundColor = self.color
      }
    }
    
    // Draw Shape
    switch self.mode {
    case .Wave:
      self.drawWave(bezierPath)
    case .Square:
      self.drawSquare(bezierPath)
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
    // Mandatory Odd number
    if self.cycles % 2 == 0 {
      self.cycles += 1
    }
    
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
  
  /*
   Add a Square shape to the navigation bar
   */
  func drawSquare(bezierPath: UIBezierPath) {
    let width = self.layer.frame.width
    let height = self.layer.frame.height
    
    bezierPath.moveToPoint(CGPointMake(0, 0))
    bezierPath.addLineToPoint(CGPointMake(0, height))

    let cycleSize: CGFloat = width / CGFloat(self.cycles * 2)
    let xOffset = cycleSize / 2

    bezierPath.addLineToPoint(CGPointMake(xOffset, height))
    
    var x = xOffset
    for i in 0..<self.cycles {
      bezierPath.addLineToPoint(CGPointMake(x, height + self.heightShape))
      x = x + cycleSize
      bezierPath.addLineToPoint(CGPointMake(x, height + self.heightShape))
      bezierPath.addLineToPoint(CGPointMake(x, height))
      
      if i + 1 != self.cycles {
        x = x + cycleSize
        bezierPath.addLineToPoint(CGPointMake(x, height))
      }
    }
    x = x + xOffset
    bezierPath.addLineToPoint(CGPointMake(x, height))
    bezierPath.addLineToPoint(CGPointMake(width, 0))
    bezierPath.closePath()
  }
  
}
