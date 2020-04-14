//:
//: MPCS51032 - Session 1 - Attributed Strings
//: ==========================================
//:

import UIKit

//: ----
//: ## Using Attributed Strings with Labels ##
//: Create a UILabel, change the color and round the corners of the label.
//: Font and color properties apply to the entire label.

let helloLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 100))
helloLabel.backgroundColor = UIColor.yellow
helloLabel.layer.masksToBounds = true
helloLabel.layer.cornerRadius = 10.0
helloLabel.textAlignment = NSTextAlignment.center
helloLabel.text = "Hello Label!"

//: ---
//: ## Let the label use an attributed string instead ##
var attributedString = NSMutableAttributedString(string: "Fancy Hello World!",
                                             attributes: [
                                              NSAttributedStringKey.font:UIFont(name: "Courier",size: 50.0)!])
helloLabel.attributedText = attributedString

//: ---
//: Setting Multiple attributes
let attributes = [NSAttributedStringKey.backgroundColor: UIColor.red,
                  NSAttributedStringKey.foregroundColor: UIColor.white,
                  NSAttributedStringKey.font:UIFont(name: "Georgia" ,size: 50.0)!
]
var fancyAttributedString = NSMutableAttributedString(string: "Super Fancy", attributes: attributes)
helloLabel.attributedText = fancyAttributedString
