//
//  ExtensionDelegate.swift
//  2020-quiz-starter WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/19/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//

import WatchKit
import UserNotifications
import CoreData

class ExtensionDelegate: NSObject, WKExtensionDelegate {
  
  func applicationDidFinishLaunching() {
    print("Application Did Finish Launching...")
    registerNotificationCategories()
    scheduleLocalNotification()
  }
  
  func applicationDidBecomeActive() {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillResignActive() {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, etc.
  }
  
  func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
    // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
    for task in backgroundTasks {
      // Use a switch statement to check the task type
      switch task {
      case let backgroundTask as WKApplicationRefreshBackgroundTask:
        // Be sure to complete the background task once you’re done.
        backgroundTask.setTaskCompletedWithSnapshot(false)
      case let snapshotTask as WKSnapshotRefreshBackgroundTask:
        // Snapshot tasks have a unique completion call, make sure to set your expiration date
        snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
      case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
        // Be sure to complete the connectivity task once you’re done.
        connectivityTask.setTaskCompletedWithSnapshot(false)
      case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
        // Be sure to complete the URL session task once you’re done.
        urlSessionTask.setTaskCompletedWithSnapshot(false)
      case let relevantShortcutTask as WKRelevantShortcutRefreshBackgroundTask:
        // Be sure to complete the relevant-shortcut task once you're done.
        relevantShortcutTask.setTaskCompletedWithSnapshot(false)
      case let intentDidRunTask as WKIntentDidRunRefreshBackgroundTask:
        // Be sure to complete the intent-did-run task once you're done.
        intentDidRunTask.setTaskCompletedWithSnapshot(false)
      default:
        // make sure to complete unhandled task types
        task.setTaskCompletedWithSnapshot(false)
      }
    }
  }
  
  
  //
  // MARK: - Notifcations
  //
  
  func registerNotificationCategories() {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
      if granted {
        print("Authorized")
      } else {
        print("Not Authorized")
      }
    }
    center.delegate = self
    
    //
    let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
    let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
    
    center.setNotificationCategories([category])
  }
  
  func scheduleLocalNotification() {
    let center = UNUserNotificationCenter.current()

    let content = UNMutableNotificationContent()
    content.title = "Time to Study"
    content.body = "A little bit each day helps your long term memory!"
    content.categoryIdentifier = "myCategory"
    content.userInfo = ["card": ["question": "5x5", "answer": "25"]]
    content.sound = UNNotificationSound.default
    
    // Create a random notification each day
    //var dateComponents = DateComponents()
    //dateComponents.hour = 10
    //dateComponents.minute = 30
    
    // For testing, just have one pop up right away
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    
    // Add the notification
    let request = UNNotificationRequest(identifier: UUID().uuidString,
                                        content: content, trigger: trigger)
    center.add(request)
  }
  

}

extension ExtensionDelegate: UNUserNotificationCenterDelegate {
  
  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
   
    // pull out the buried userInfo dictionary
    let userInfo = response.notification.request.content.userInfo
    print(">>>>>> \(userInfo)")
    print(">>>>>> \(response.actionIdentifier)")
    //if let customData = userInfo["customData"] as? String {
    //print("Custom data received: \(customData)")
    
    switch response.actionIdentifier {
      
    case UNNotificationDefaultActionIdentifier:
      // the user swiped to unlock
      print("Default identifier")
      
    case "incorrect":
      // the user tapped our "show more info…" button
      print("Show more information…")
      
    default:
      break
      //  }
    }
    
    // you must call the completion handler when you're done
    completionHandler()
  }

}
