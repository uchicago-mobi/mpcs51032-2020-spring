//
//  NotificationController.swift
//  2020-quiz-starter WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/19/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//

import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {
  
  var card: Card!
  
  override var body: NotificationView {
    
    return NotificationView(card: card)
    
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  override func didReceive(_ notification: UNNotification) {
    // This method is called when a notification needs to be presented.
    // Implement it if you use a dynamic notification interface.
    // Populate your dynamic notification interface as quickly as possible.
    print(notification.request.content)
    
    guard let cardInfo = (notification.request.content.userInfo["card"] ?? [:]) as? [String: String] else {
      return
    }
    
    // Create a Card from the information in the notification.
    card = Card(question: cardInfo["question"]!, answer: cardInfo["answer"]!)
    
    notificationActions = [
      UNNotificationAction(identifier: "correct", title: "Correct", options: [.foreground]),
      UNNotificationAction(identifier: "incorrect", title: "Incorrect", options: [.destructive])
    ]
  }
}
