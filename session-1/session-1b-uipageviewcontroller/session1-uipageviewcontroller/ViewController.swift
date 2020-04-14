//
//  ViewController.swift
//  session1-uipageviewcontroller
//
//  Created by T. Andrew Binkowski on 4/6/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  var pageController: UIPageViewController!
  /// Array of controllers that will be managed by the page view controller
  var controllers = [UIViewController]()
  
  //
  // MARK: - Lifecycle Functions
  //
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pageController = UIPageViewController(transitionStyle: .scroll,
                                          navigationOrientation: .horizontal,
                                          options: nil)
    pageController.dataSource = self
    pageController.delegate = self
    
    // Adding to the existing view controller
    addChild(pageController)

    // adding the view; i could make this not full screen
    // leave part of the screen of "ViewController" and have a home button
    //
    view.addSubview(pageController.view)
    
    
    for counter in 1 ... 5 {
      
      let vc = UIViewController()
      
      vc.view.backgroundColor = randomColor()
      
      let label = UILabel()
      label.text = "\(counter)"
      label.font = UIFont.boldSystemFont(ofSize: 200)
      label.translatesAutoresizingMaskIntoConstraints = false
      vc.view.addSubview(label)
      label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
      label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
      controllers.append(vc)
    }
    
    pageController.setViewControllers([controllers[0]],
                                      direction: .forward,
                                      animated: false)
  }

  //
  // MARK: - Helper Functions
  //
  func randomCGFloat() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
  }
  
  func randomColor() -> UIColor {
    return UIColor(red: randomCGFloat(), green: randomCGFloat(), blue: randomCGFloat(), alpha: 1)
  }
  
}


///
/// View Controller Data Source
///
extension ViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerBefore viewController: UIViewController) -> UIViewController? {
   
    if let index = controllers.firstIndex(of: viewController) {
      if index > 0 {
        return controllers[index - 1]
      } else {
        return nil
      }
    }
    return nil
  }
  
  func pageViewController(_ pageViewController: UIPageViewController,
                          viewControllerAfter viewController: UIViewController) -> UIViewController? {
    if let index = controllers.firstIndex(of: viewController) {
      if index < controllers.count - 1 {
        return controllers[index + 1]
      } else {
        return nil
      }
    }
    
    return nil
  }

}
