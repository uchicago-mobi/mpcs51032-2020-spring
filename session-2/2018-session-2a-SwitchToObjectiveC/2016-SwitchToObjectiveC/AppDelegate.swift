//
//  AppDelegate.swift
//  2020-SwitchToObjectiveC
//
//  Created by T. Andrew Binkowski on 4/3/20.
//  Copyright © 2016 The University of Chicago, Department of Computer Science. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    let defaults = UserDefaults.standard
    print(defaults.bool(forKey: "kSoundPreference"))
    
    
    
    return true
  }



}

