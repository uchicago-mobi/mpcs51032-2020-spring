//
//  CircleImageView.swift
//  2018-session-7-designable-inspectable
//
//  Created by T. Andrew Binkowski on 5/26/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {

  @IBInspectable public var rounded: Bool = false {
        didSet {
          if rounded {
            self.layer.cornerRadius = 125
          } else {
            self.layer.cornerRadius = 0
          }
          self.setNeedsDisplay()
        }
      }
}
