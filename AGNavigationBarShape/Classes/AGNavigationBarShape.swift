//
//  AGNavigationBarShape.swift
//  AGNavigationBarShape
//
//  Created by Aurelien Grifasi on 14/05/16.
//  Copyright © 2016 Aurelien Grifasi. All rights reserved.
//

import UIKit

open class AGNavigationBarShape: UINavigationBar {
  
  // Availables Shapes
  public enum ShapeMode: Int {
    case zigzag = 0
    case wave
    case square
  }
  
  open var mode: ShapeMode = ShapeMode.zigzag
  let heightShape: CGFloat = 10
  
  @IBInspectable open var color: UIColor = UIColor(red: (251.0/255.0), green: (101.0/255), blue: (68.0/255.0), alpha: 1.0)
  @IBInspectable open var cycles: Int = 9
  @IBInspectable var shapeMode: Int {
    get {
      return self.mode.rawValue
    }
    set(shapeIndex) {
      self.mode = ShapeMode(rawValue: shapeIndex) ?? .zigzag
    }
  }
  
  // Methods
  
  override open func draw(_ rect: CGRect) {
    let bezierPath: UIBezierPath = UIBezierPath()
    
    // Apply color on status bar
    if let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView {
      if statusBar.responds(to: #selector(setter: UIView.backgroundColor)) {
        statusBar.backgroundColor = self.color
      }
    }
    
    // Draw Shape
    switch self.mode {
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
    
    // Display Shape thanks to layer shadow
    self.layer.shadowColor = self.color.cgColor
    self.layer.shadowOffset = CGSize(width: 0.0, height: self.heightShape)
    self.layer.shadowOpacity = 1
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
      bezierPath.addLine(to: CGPoint(x: x, y: height + self.heightShape))
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
    // Mandatory Odd number
    if self.cycles % 2 == 0 {
      self.cycles += 1
    }
    
    let width = self.layer.frame.width
    let height = self.layer.frame.height

    bezierPath.move(to: CGPoint(x: 0, y: 0))
    bezierPath.addLine(to: CGPoint(x: 0, y: height))

    let cycleSize = width / CGFloat(self.cycles)
    var x: CGFloat = 0
    let yc: CGFloat = height + (10 / 2)
    for i in 0..<self.cycles {
      if ((i % 2) == 0) {
        if ((i + 1) == self.cycles) {
          bezierPath.addQuadCurve(to: CGPoint(x: x + cycleSize, y: height), controlPoint: CGPoint(x: x + cycleSize / 2, y: yc + 5))
        } else {
          bezierPath.addQuadCurve(to: CGPoint(x: x + cycleSize, y: yc), controlPoint: CGPoint(x: x + cycleSize / 2, y: yc + 5))
        }
      } else {
        if ((i + 1) == self.cycles) {
          bezierPath.addQuadCurve(to: CGPoint(x: x + cycleSize, y: height), controlPoint: CGPoint(x: x + cycleSize / 2, y: yc - 5))
        } else {
          bezierPath.addQuadCurve(to: CGPoint(x: x + cycleSize, y: yc), controlPoint: CGPoint(x: x + cycleSize / 2, y: yc - 5))
        }
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

    bezierPath.addLine(to: CGPoint(x: xOffset, y: height))
    
    var x = xOffset
    for i in 0..<self.cycles {
      bezierPath.addLine(to: CGPoint(x: x, y: height + self.heightShape))
      x = x + cycleSize
      bezierPath.addLine(to: CGPoint(x: x, y: height + self.heightShape))
      bezierPath.addLine(to: CGPoint(x: x, y: height))
      
      if i + 1 != self.cycles {
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
