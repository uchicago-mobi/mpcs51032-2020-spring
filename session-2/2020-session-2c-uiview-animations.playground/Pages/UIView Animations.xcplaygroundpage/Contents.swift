//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
  override func loadView() {
    let view = UIView()
    view.backgroundColor = .white
    self.view = view
  }
  
  
  
  override func viewDidLoad() {
    
    // Add a green box to our container view
    let greenView = UIView(frame: CGRect(x: 160, y: 160, width: 50, height: 50))
    greenView.backgroundColor = UIColor.green
    self.view.addSubview(greenView)
    
    // Add a red box to our container view
    let redView = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
    redView.backgroundColor = UIColor.red
    self.view.addSubview(redView)
    
    
    // Add a rotation transform to our red box view
    UIView.animate(withDuration: 3.0, animations: { () -> Void in
      let rotationTransform = CGAffineTransform(rotationAngle: 3.14)
      redView.transform = rotationTransform
    })
   
    // Fade out the green
    UIView.animate(withDuration: 2) {
      greenView.alpha = 0
    }
  }
  
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

