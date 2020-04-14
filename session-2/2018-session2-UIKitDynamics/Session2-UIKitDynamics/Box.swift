//
//  Box.swift
//  Session2-UIKitDynamics
//
//  Created by T. Andrew Binkowski on 4/1/16.
//  Copyright (c) 2016 Department of Computer Science, The University of Chicago. All rights reserved.
//

import Foundation
import UIKit

class Box : UIView {
  
  /// Random color box
  let color: UIColor = {
    let red = CGFloat(CGFloat(arc4random()%100000)/100000)
    let green = CGFloat(CGFloat(arc4random()%100000)/100000)
    let blue = CGFloat(CGFloat(arc4random()%100000)/100000)
    
    return UIColor(red: red, green: green, blue: blue, alpha: 0.85)
  }()
  
  /// Random frame
  let randomFrame: CGRect = {
    let x = CGFloat(arc4random()).truncatingRemainder(dividingBy: 100)
    let y = CGFloat(arc4random()).truncatingRemainder(dividingBy: 100)
    return CGRect(x: x, y: y, width: 30, height: 30)
  }()
  
  var myFrame: CGRect?
  
  /// Keep track if it bounced
  var bounced : Bool = false
  
  
  //
  // MARK: - Initializers
  //
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(number: Int) {
    self.init(frame:CGRect.zero)
    tag = number
    commonInit()
  }
  
  func commonInit() {
    self.backgroundColor = color
    self.frame = randomFrame
  }
  
  
  //
  // MARK: - Helpers
  //
  
}
