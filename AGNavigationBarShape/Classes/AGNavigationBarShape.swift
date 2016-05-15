//
//  AGNavigationBarShape.swift
//  AGNavigationBarShape
//
//  Created by Aurelien Grifasi on 14/05/16.
//  Copyright © 2016 aurelien.grifasi. All rights reserved.
//

import UIKit

public class AGNavigationBarShape: UINavigationBar {
  
  public enum ShapeMode: Int {
    case Wave = 0
    case Zigzag
  }
  
  @IBInspectable public var statusBarColor: UIColor? = UIColor.whiteColor()
  @IBInspectable public var navigationBarColor: UIColor? = UIColor.whiteColor()
  @IBInspectable public var nbShape: Int = 10
  @IBInspectable public var shapeMode: Int {
    get {
      return self.mode.rawValue
    }
    set(shapeIndex) {
      self.mode = ShapeMode(rawValue: shapeIndex) ?? .Zigzag
    }
  }
  
  public var mode: ShapeMode = ShapeMode.Zigzag
  
  
  // Methods
  
  override public func drawRect(rect: CGRect) {
    
    // Apply color on status bar
    if let statusBarColor = statusBarColor {
      let statusBar: UIView = UIApplication.sharedApplication().valueForKey("statusBar") as! UIView
      if statusBar.respondsToSelector(Selector("setBackgroundColor:")) {
        statusBar.backgroundColor = statusBarColor
      }
    }
    
    switch self.mode {
    case .Wave:
      self.drawZigzag()
    case .Zigzag:
      self.drawZigzag()
    }
  }
  
  /*
   Add a Zigzag form to the navigation bar
   */
  func drawZigzag() {
    // Get Height and Width
    let layerHeight = self.layer.frame.height
    let layerWidth = self.layer.frame.width
    
    // Create Path
    let bezierPath = UIBezierPath()
    
    // Variables
    let halfShape: CGFloat = (layerWidth / CGFloat(self.nbShape)) / 2
    let heightShape: CGFloat = 10
    var x: CGFloat = 0
    
    // Draw Points
    bezierPath.moveToPoint(CGPointMake(0, 0))
    bezierPath.addLineToPoint(CGPointMake(0, layerHeight))
    for _ in 1...(self.nbShape * 2) {
      x = x + halfShape
      bezierPath.addLineToPoint(CGPointMake(x, layerHeight + heightShape))
      x = x + halfShape
      bezierPath.addLineToPoint(CGPointMake(x, layerHeight))
    }
    bezierPath.addLineToPoint(CGPointMake(layerWidth, 0))
    bezierPath.closePath()
    
    // Apply color on navigation bar
    if let navigationBarColor = navigationBarColor {
      navigationBarColor.setFill()
    } else {
      UIColor.whiteColor().setFill()
    }
    bezierPath.fill()
    
    // Mask to Path
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = bezierPath.CGPath
    self.layer.mask = shapeLayer
    
    if let navigationBarColor = navigationBarColor {
      self.layer.shadowColor = navigationBarColor.CGColor
    } else {
      self.layer.shadowColor = UIColor.whiteColor().CGColor
    }
    self.layer.shadowOffset = CGSizeMake(0.0, heightShape)
    self.layer.shadowOpacity = 1
    self.layer.shouldRasterize = true
  }
}
