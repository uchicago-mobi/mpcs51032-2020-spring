//
//  DesignerView.swift
//  2017-PerformaceWithInstruments
//
//  Created by T. Andrew Binkowski on 5/20/17.
//  Copyright © 2017 T. Andrew Binkowski. All rights reserved.
//

import UIKit

@IBDesignable

class DesignerView: UIView {
  @IBInspectable public var color: UIColor = UIColor.clear {
    didSet {
      self.backgroundColor = color
    }
  }
  
  @IBInspectable var borderColor: UIColor = UIColor.white {
    didSet {
      self.layer.borderColor = borderColor.cgColor
    }
  }
  
  @IBInspectable var borderWidth: CGFloat = 1.0 {
    didSet {
      self.layer.borderWidth = borderWidth
    }
  }
  
  @IBInspectable
  public var cornerRadius: CGFloat = 2.0 {
    didSet {
      self.layer.cornerRadius =  cornerRadius
    }
  }
  
}



