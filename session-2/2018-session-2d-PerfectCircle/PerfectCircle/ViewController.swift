//
//  ViewController.swift
//  PerfectCircle
//
//  Created by T. Andrew Binkowski on 4/9/18.
//  Copyright © 2018 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {

  @IBOutlet weak var tempImageView: UIImageView!
  
  var lastPoint = CGPoint.zero
  var brushWidth: CGFloat = 10.0
  var opacity: CGFloat = 1.0
  var drawing = false

  /// Collect every point that is drawn
  var points = [CGPoint]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  /// Draw a line segment
  func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
    
    // Create the canvas
    UIGraphicsBeginImageContext(view.frame.size)
    let context = UIGraphicsGetCurrentContext()
    tempImageView.image?.draw(in: CGRect(x: 0, y: 0,
                                         width: view.frame.size.width,
                                         height: view.frame.size.height))
    
    // Create line segment
    context!.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
    context!.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
    
    // Set the `pen`
    context!.setLineCap(.round)
    context!.setLineWidth(brushWidth)
    context!.setStrokeColor(UIColor.black.cgColor)
    context!.setBlendMode(.normal)
    
    // Stroke the path with the pen
    context!.strokePath()
    
    // Copy the canvas on the imageview
    tempImageView.image = UIGraphicsGetImageFromCurrentImageContext()
    tempImageView.alpha = opacity
    UIGraphicsEndImageContext()
    
  }
  
  //
  // MARK: - Touches
  //
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("Began")
    drawing = false
    if let touch = touches.first {
      lastPoint = touch.location(in: self.view)
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("Moved")

    drawing = true
    if let touch = touches.first {
      let currentPoint = touch.location(in: view)
      drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
      lastPoint = currentPoint
      print(currentPoint)
    }
  }
  
  override  func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("Ended")
    if !drawing {
      drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
    }
    tempImageView.image = nil
  }
  

}

