//
//  ExtensionDelegate.swift
//  watchos-coedata WatchKit Extension
//
//  Created by T. Andrew Binkowski on 5/19/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//

import WatchKit
import CoreData

//
//
//
class ExtensionDelegate: NSObject, WKExtensionDelegate {

  func applicationDidFinishLaunching() {
    // Add some data everytime the app is loaded
    let managedObjectContext = (WKExtension.shared().delegate as! ExtensionDelegate).persistentContainer.viewContext
    let question = Question(context: managedObjectContext)
    question.question = "5 x 5"
    question.answer = "25"
    saveContext()
  }
  
  func applicationWillResignActive() {
    self.saveContext()

  }
  
  //
  // MARK: - Core Data Stack
  //
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Quiz")
    container.loadPersistentStores { description, error in
      if let error = error {
        // Add your error UI here
        print("error")
      }
    }
    return container
  }()
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        // Show the error here
      }
    }
  }

}
