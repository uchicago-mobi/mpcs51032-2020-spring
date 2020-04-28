//
//  AppDelegate.swift
//  ShareExtension
//
//  Created by T. Andrew Binkowski on 4/21/20.
//  Copyright (c) 2020 The University of Chicago. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // If the app was not in the background, it will launch with the options
    // key `UIAPplicationLaunchOptionsURLKey`
    if let options = launchOptions {
      let alertView = UIAlertView(title: "Launch Options", message: options.description,
                                  delegate: nil,
                                  cancelButtonTitle: "Cancel",
                                  otherButtonTitles: "OK")
      alertView.alertViewStyle = .default
      alertView.show()
    }
    
    // Print out the app group path for debugging
    let sharedAppGroup: String = "group.extensiontest2"
    let directory: URL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: sharedAppGroup)!
    print("👉 App Group URL: \(directory)")

    
    return true
  }
  
  func application(_ application: UIApplication,
                   open url: URL,
                   sourceApplication: String?,
                   annotation: Any) -> Bool {
    print("The application was launched from the url: \(url)")
    return true
  }
  
  
}

