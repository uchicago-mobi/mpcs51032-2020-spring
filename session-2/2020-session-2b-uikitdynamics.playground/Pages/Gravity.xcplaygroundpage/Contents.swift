//: UIKit Dynamics Gravity

import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
  
  var animator:UIDynamicAnimator? = nil;
  let gravity = UIGravityBehavior()
  
  
  override func loadView() {
    let view = UIView()
    view.backgroundColor = .white
    self.view = view
    play()
  }
  
  
  func play() {
    
    let square = UIView(frame: CGRect(x: 100, y: 100, width: 40, height: 40))
    square.backgroundColor = UIColor.gray
    self.view.addSubview(square)

    // Instantiate the Animator
    self.animator = UIDynamicAnimator(referenceView: self.view)
   
    // Setup a behavior
    let gravity = UIGravityBehavior(items: [square])
    gravity.gravityDirection = CGVector(dx: 0, dy: 0.8)
    // Add the behavior to the animator
    animator?.addBehavior(gravity)
    
    // Setup up another behavior
    let collision = UICollisionBehavior(items: [square])
    collision.translatesReferenceBoundsIntoBoundary = true
    // Add to the animator
    animator?.addBehavior(collision)

    // Create a new view for the boundary
    let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 110, height: 20))
    barrier.backgroundColor = UIColor.red
    self.view.addSubview(barrier)

    let rightEdge = CGPoint(x: barrier.frame.origin.x + barrier.frame.size.width,
                            y: barrier.frame.origin.y)
    collision.addBoundary(withIdentifier: "barrier" as NSCopying,
                          from: barrier.frame.origin, to: rightEdge)
  }
  

}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
PlaygroundPage.current.needsIndefiniteExecution = true

