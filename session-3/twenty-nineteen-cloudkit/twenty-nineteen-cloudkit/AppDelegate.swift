//
//  AppDelegate.swift
//  twenty-nineteen-cloudkit
//
//  Created by T. Andrew Binkowski on 11/4/19.
//  Copyright © 2019 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    
    // Register a subscription for this device to let us know about
    // any changes to a `Joke` record
    CloudKitManager.sharedInstance.registerJokeSubscription()
    
    // Request authorization for notifications (this will present the user dialogue)
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
      if let error = error {
        print("D'oh: \(error.localizedDescription)")
      } else {
        // CloudKit operates on a background thread
        DispatchQueue.main.async {
          application.registerForRemoteNotifications()
        }
      }
    }
    
    // Set delegate to receive notifications in all cases
    UNUserNotificationCenter.current().delegate = self
    
    // If the application is launced from a notification, we have to handle
    // it here instead of the `didReceiveRemoteNotification` method below.
    // Parse the launch notification so that we can get the payload
    if let notification = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? [String: AnyObject] {
      let aps = notification["aps"] as! [String: AnyObject]
      print("APS: \(aps)")
    }
    return true
  }
  
  
  //
  // MARK: - Notifications
  //
  
  /// Call when application is open and a notification is received; this is only necesary
  /// if we want a notification to show on the screen. It is still delivered...just silently
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound, .badge])
  }
  
  /// Called for push notifications coming from an APNS server.
  /// In this case, we are getting the changed record from cloudkit and then creating
  /// a new notification
  func application(_ application: UIApplication,
                   didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                   fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    
    // Get the APS notification data from the payload
    print("☁️ Debugging: \(userInfo)")
    let aps = userInfo["aps"] as! [String: AnyObject]
    
    // Do Something with the content available data (if its there)
    let contentAvailable = aps["content-available"] as! Int
    if contentAvailable == 1 {
      let cloudKitInfo = userInfo["ck"] as! [String: AnyObject]
      let recordId = cloudKitInfo["qry"]?["rid"] as! String
      let field = cloudKitInfo["qry"]?["af"] as! [String: AnyObject]
      
      // A message indicates that we have a received a silent notification.
      // For debugging purposes, we are going to present a notification to
      // screen. This is only forr debugging!
      if let question = field["question"] as? String {
        local_notification_from_silent(message: question, recordId: recordId)
      }
      completionHandler(.newData)
      
    } else {
      completionHandler(.noData)
    }
  }
  
  /// This is only for debugging. It will present a local notification to the
  /// device because a normal APNS is a silent notification.
  func local_notification_from_silent(message: String, recordId: String) {
    // Create notification content
    let content = UNMutableNotificationContent()
    content.title = "😂 Joke Record ID: \(recordId)"
    content.subtitle = "This would be a good place to sync your local data."
    content.body = message
    content.sound = UNNotificationSound.default
    
    // Set up trigger
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,repeats: false)
    
    // Create the notification request
    let center = UNUserNotificationCenter.current()
    let identifier = recordId
    let request = UNNotificationRequest(identifier: identifier,
                                        content: content, trigger: trigger)
    center.add(request, withCompletionHandler: { (error) in
      if let error = error {
        print("Something went wrong: \(error)")
      }
    })
  }
 
  //
  // MARK: UISceneSession Lifecycle
  //
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
}

