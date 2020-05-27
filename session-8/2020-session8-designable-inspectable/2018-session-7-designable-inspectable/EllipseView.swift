//
//  EllipseView.swift
//  2018-session-7-designable-inspectable
//
//  Created by T. Andrew Binkowski on 5/26/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//

import UIKit

@IBDesignable class ShapeView: UIView {
  
    @IBInspectable var strokeColor: UIColor = UIColor.black
    @IBInspectable var fillColor: UIColor = UIColor.clear
  
    var path: UIBezierPath?

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    override func layoutSubviews() {
        guard let layer = layer as? CAShapeLayer else { return }
        layer.path = path?.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = fillColor.cgColor
    }

  override func prepareForInterfaceBuilder() {
      let drawRect = CGRect(x: 0, y: 0, width: 200, height: 200)
      path = UIBezierPath(ovalIn: drawRect)
  }

}
 
