//
//  ViewController.swift
//  2018-session-7-designable-inspectable
//
//  Created by T. Andrew Binkowski on 5/13/18.
//  Copyright © 2018 T. Andrew Binkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    for i in 0...1000000 {
     // print(i)
      
      
      if i % 10 == 0 {
        evenNumber(i)
        sleep(10)
      }
      
    }
  }
  
  func evenNumber(_ i: Int) {
    print("😀 \(i)")
  }
}

