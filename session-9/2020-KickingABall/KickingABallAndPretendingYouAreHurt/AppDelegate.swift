//
//  AppDelegate.swift
//  KickingABallAndPretendingYouAreHurt
//
//  Created by T. Andrew Binkowski on 5/16/16.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // This is a localization test (it has nothing to do with accessibility)
    let greeting = NSLocalizedString("GREETING", comment: "This is a greeting.")
    print("Greeting \(greeting)")
    
    let age = String(format: NSLocalizedString("AGE", comment: "Comment doesn't do anything useful"),"5")
    print("Age \(age)")
    
    
    return true
  }
  
}

