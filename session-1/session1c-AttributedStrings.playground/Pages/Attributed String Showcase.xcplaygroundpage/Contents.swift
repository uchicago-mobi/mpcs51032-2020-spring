//:
//: Attributed String Showcase
//: ==========================
//:

import UIKit

// Create a view to visualize the changes
let label = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 100))
label.backgroundColor = .lightGray
label.textAlignment = NSTextAlignment.center
label.text = "Boring"

//: Note that attributed string attributes are cumulative.  They will persist on
//: that string until you change/undo them.  For highlighting words for the
//: homework assignment, you will need to reset the previously highlighted words
//: to the default attributes.

// Create an attributed string
var attributedString = NSMutableAttributedString()
//: Create an attributed string with fancy text
var attributes = [NSAttributedStringKey.font: UIFont(name: "ChalkboardSE-Regular" ,size: 50.0)!]
attributedString = NSMutableAttributedString(string: "Hello World!", attributes: attributes)
label.attributedText = attributedString
//: Changing the font over a specified range defined by `NSRange`.
attributedString.addAttribute(NSAttributedStringKey.font,
                              value: UIFont(name: "AmericanTypewriter-Bold", size: 18.0)!,
                              range: NSRange(location:0,length:5))
label.attributedText = attributedString

//: Change font in range, stroke the letter and change color
attributedString.addAttribute(NSAttributedStringKey.font,
                              value: UIFont(name: "Georgia", size: 100.0)!,
                              range: NSRange(location: 0, length: 1))
label.attributedText = attributedString

// Stroke the first letter in red
attributedString.addAttribute(NSAttributedStringKey.strokeColor,
                              value: UIColor.red,
                              range:  NSRange(location: 0, length: 4))
label.attributedText = attributedString

// Stroke Width
attributedString.addAttribute(NSAttributedStringKey.strokeWidth,
                              value: 2,
                              range: NSRange(location: 0, length: 1))
label.attributedText = attributedString

// Change the background color
attributedString.addAttribute(NSAttributedStringKey.backgroundColor,
                              value: UIColor.yellow,
                              range: NSRange(location: 0, length: 6))
label.attributedText = attributedString

