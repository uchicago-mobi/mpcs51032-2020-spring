import UIKit
import PlaygroundSupport

// Container for our animating view
let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
let containerView = HeartContainerView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
let heart = containerView.heart

// Show the container view in the Assistant Editor
PlaygroundPage.current.liveView = containerView


//
//
///// Move and Fade (similiar to UIViewAnimation)
UIViewPropertyAnimator(duration: 3, curve: .easeInOut) {
  heart.alpha = 0
  heart.center = heart.superview!.center
  heart.transform = CGAffineTransform(scaleX: 5, y: 5)
}.startAnimation()



/// Alternative call
//let animator = UIViewPropertyAnimator(duration: 5,
//                                      curve: .easeInOut)
//// Add animation block
//animator.addAnimations {
//  heart.alpha = 0
//}
//
//// Now here goes our second
//animator.addAnimations {
//  heart.center = heart.superview!.center
//}
//animator.startAnimation()

/// Add completion block
//animator.addCompletion { (position) in
//  switch position {
//  case .end: print("Completion handler called at end of animation")
//  case .current: print("Completion handler called mid-way through animation")
//  case .start: print("Completion handler called  at start of animation")
//  }
//}




/// Reverse the animation
//let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 30)))
//button.setTitle("Reverse", for: .normal)
//button.setTitleColor(.black, for: .normal)
//button.setTitleColor(.gray, for: .highlighted)
//let listener = EventListener()
//listener.eventFired = {
//  animator.isReversed = true
//}
//
//button.addTarget(listener, action: #selector(EventListener.handleEvent), for: .touchUpInside)
//containerView.addSubview(button)


/// Start/stop the animation
//let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 30)))
//button.setTitle("Pause", for: .normal)
//button.setTitleColor(.black, for: .normal)
//button.setTitleColor(.gray, for: .highlighted)
//
//let listener = EventListener()
//listener.eventFired = {
//  if animator.isRunning {
//    animator.pauseAnimation()
//  } else {
//    animator.startAnimation()
//  }
//}
//
//button.addTarget(listener, action: #selector(EventListener.handleEvent), for: .touchUpInside)
//containerView.addSubview(button)
//
