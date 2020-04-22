//
//  CloudKitManager.swift
//  CloudKit-1
//
//  Created by T. Andrew Binkowski on 11/4/19.
//  Copyright © 2019 T. Andrew Binkowski. All rights reserved.
//

import Foundation
import CloudKit

open class CloudKitManager {
  
  public static let sharedInstance = CloudKitManager()
  
  //
  // MARK: - CloudKit
  //
  
  let container: CKContainer = CKContainer.default()
  let publicDB: CKDatabase = CKContainer.default().publicCloudDatabase
  let privateDB: CKDatabase = CKContainer.default().privateCloudDatabase
  let currentDB: CKDatabase = CKContainer.default().publicCloudDatabase
  
  /// Current user
  var userRecordID: CKRecord.ID?
  
  
  //
  // MARK: - Singleton
  //
  
  // Keep it safe
  private init() {}
  
  
  //
  // MARK: - User Records
  //
  
  /// Get the users `RecordId`
  /// - parameters complete: A completion block passing two parameters
  open func getUserRecordId(complete: @escaping (CKRecord.ID?, NSError?) -> ()) {
    
    self.container.fetchUserRecordID() {
      recordID, error in
      
      if error != nil {
        print(error!.localizedDescription)
        complete(nil, error as NSError?)
      } else {
        // We have access to the user's record
        print("☁️ fetched ID \(recordID?.recordName ?? "")")
        complete(recordID, nil)
      }
    }
  }
  
  /// Get the users identity (name)
  /// - parameters userRecordID: The user's recordID from CloudKit
  /// - parameters complete: A completion block passing two parameters
  open func getUserIdentity(userRecordID: CKRecord.ID?, complete: @escaping (String?, NSError?) -> ()) {
    
    self.container.discoverUserIdentity(withUserRecordID: userRecordID!,
                                        completionHandler: { (userID, error) in
                                          let userName = (userID?.nameComponents?.givenName)! + " " + (userID?.nameComponents?.familyName)!
                                          print("☁️ CloudKit User Name: " + userName)
                                          complete(userName,nil)
    })
  }
  
  
  //
  // MARK: - Modify/Create Records
  //
  
  
  /// Create a joke record and save to iCloud using CloudKit
  /// - parameter joke: Funny string
  /// - remark: Error handling leaves something to be desired
  func addJoke(_ joke: String, response: String) {
    
    let record = CKRecord(recordType: "joke")
    record.setValue(joke, forKey: "question")
    record["response"] = response as CKRecordValue
    record["rating_positive"] = 0 as CKRecordValue
    record["rating_negative"] = 0 as CKRecordValue
    
    currentDB.save(record) { (record, error) in
      if let error = error {
        print("☁️ Error: \(error.localizedDescription)")
        return
      }
      print("☁️ Saved record: \(record.debugDescription)")
    }
  }
  
  // func imageToAsset() -> CKAsset {
  //
  //    let data = Image.pngPNGRepresentation(myImage); // UIImage -> NSData, see also UIImageJPEGRepresentation
  //  let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(NSUUID().UUIDString+".dat")
  //  do {
  //      try data!.writeToURL(url, options: [])
  //  } catch let e as NSError {
  //      print("Error! \(e)");
  //      return
  //  }
  //  newUser["photo"] = CKAsset(fileURL: url)
  //
  //  // ...
  //
  //  publicData.saveRecord(newUser, completionHandler: { (record: CKRecord?, error: NSError?) in
  //      // Delete the temporary file
  //      do { try NSFileManager.defaultManager().removeItemAtURL(url) }
  //      catch let e { print("Error deleting temp file: \(e)") }
  //
  //      // ...
  //  }
  //
  // }
  
  
  //
  // MARK: - Queries
  //
  
  /// Retrieve a specific record by its ID
  open func getRecordById(_ recordId: CKRecord.ID,
                          completion: @escaping (CKRecord?, NSError?) -> ()) {
    
    currentDB.fetch(withRecordID: recordId) { (record, error) in
      if let error = error {
        print("☁️ Error: \(String(describing: error.localizedDescription))")
        completion(nil, error as NSError?)
      }
      if let record = record {
        print(record.description)
        completion(record, nil)
      }
    }
    
  }
  
  /// Get all jokes by a user
  /// - parameter recordID: The `CKRecordID` of the current user
  open func getJokesByCurrentUser(_ recordID: CKRecord.ID) {
    
    // The user is a reference, so we need to query against a reference
    let reference = CKRecord.Reference(recordID: recordID, action: .none)
    
    
    let predicate = NSPredicate(format: "creatorUserRecordID == %@", reference)
    
    let query = CKQuery(recordType: "joke", predicate: predicate)
    currentDB.perform(query, inZoneWith: nil) { (records, error) -> Void in
      if let error = error {
        print("Error: \(String(describing: error.localizedDescription))")
        return
      }
      for record in records! {
        print("☁️ \(record["question"] as! String))")
      }
    }
  }
  
  
  /// Get all jokes in the public database
  open func getJokes() {
    let predicate = NSPredicate(format: "TRUEPREDICATE")
    
    let query = CKQuery(recordType: "joke", predicate: predicate)
    currentDB.perform(query, inZoneWith: nil) { (records, error) -> Void in
      if let error = error {
        print("Error: \(String(describing: error.localizedDescription))")
        return
      }
      for record in records! {
        print("😂: \(record["question"] as! String)")
      }
    }
  }
  
  
  /// Use the operation API to make a query and use cursors
  /// to control the folow of data
  /// - parameter query: A `CKQuery?`, most likely represents the initial query
  open func getJokesWithOperation(query: CKQuery?, cursor: CKQueryOperation.Cursor?) {
    var queryOperation: CKQueryOperation!
    
    if query != nil {
      let predicate = NSPredicate(value: true)
      let query = CKQuery(recordType: "joke", predicate: predicate)
      queryOperation = CKQueryOperation(query: query)
    } else if let cursor = cursor {
      print("== Cursor ======================================================")
      queryOperation = CKQueryOperation(cursor: cursor)
    }
    
    // Query parameters
    //queryOperation.desiredKeys = ["", "", ""]
    queryOperation.queuePriority = .veryHigh
    queryOperation.resultsLimit = 2
    queryOperation.qualityOfService = .userInteractive
    
    // This gets called each time per record
    queryOperation.recordFetchedBlock = {
      (record: CKRecord!) -> Void in
      if record != nil {
        print("😂 operation: \(record["question"] as! String)")
      }
    }
    
    // This is called after all records are retrieved and iterated
    // on
    queryOperation.queryCompletionBlock = { cursor, error in
      if (error != nil) {
        print("Error:\(String(describing: error))")
        return
      }
      
      if let cursor = cursor {
        print("There is more data to fetch")
        self.getJokesWithOperation(query: nil, cursor: cursor)
        
        print("Done with opeartion...")
        //OperationQueue.main.addOperation() {
        // Do anything else with the record after downloaded that
        // needs to be on the main thread
        //}
      }
    }
    self.currentDB.add(queryOperation)
  }
  
  
  // 
  // MARK: - Subscriptions
  //
//
//  func registerJokeOfTheDaySubscriptions() {
//    // Unique identifier for the subscription
//    let uuid: UUID = UUID()
//    let identifier = "\(uuid)-joke-of-the-day"
//
//    // Create the notification that will be delivered
//    let notificationInfo = CKSubscription.NotificationInfo()
//    notificationInfo.alertBody = "The Joke of the Day is here! 😂"
//    notificationInfo.shouldBadge = true
//    notificationInfo.shouldSendContentAvailable = true
//    notificationInfo.desiredKeys = ["joke"]
//
//    // Create the subscription object
//    let subscription = CKQuerySubscription(recordType: "joke_of_the_day",
//                                           predicate: NSPredicate(value: true),
//                                           subscriptionID: identifier,
//                                           options: [
//                                            CKQuerySubscription.Options.firesOnRecordCreation])
//
//    subscription.notificationInfo = notificationInfo
//
//    // Save subscription
//    currentDB.save(subscription, completionHandler: ({returnRecord, error in
//      if let err = error {
//        print("JOTD: subscription failed \(err.localizedDescription)")
//      } else {
//        print("JOTD: subscription set up")
//      }
//    }))
//  }
//
//
//
//  func registerSilentAlertSubscription() {
//    let uuid: UUID = UUID()
//    let identifier = "\(uuid)-alert"
//
//
//    // Create the notification that will be delivered
//    let notificationInfo = CKSubscription.NotificationInfo()
//    notificationInfo.shouldSendContentAvailable = true
//    notificationInfo.desiredKeys = ["message"]
//
//    // Create the subscription
//    let subscription = CKQuerySubscription(recordType: "alert",
//                                           predicate: NSPredicate(value: true),
//                                           subscriptionID: identifier,
//                                           options: [CKQuerySubscription.Options.firesOnRecordCreation])
//
//    subscription.notificationInfo = notificationInfo
//    CKContainer.default().publicCloudDatabase.save(subscription,
//                                                   completionHandler: ({returnRecord, error in
//                                                    if let err = error {
//                                                      print("ALERT: subscription failed \(err.localizedDescription)")
//                                                    } else {
//                                                      print("ALERT: subscription set up")
//                                                    }
//                                                   }))
//  }
  
  
  func registerJokeSubscription() {
    let uuid: UUID = UUID()
    let identifier = "\(uuid)-joke"
    
    // Create the notification that will be delivered
    let notificationInfo = CKSubscription.NotificationInfo()
    notificationInfo.shouldSendContentAvailable = true
    notificationInfo.desiredKeys = ["question","response"]
    
    // Create the subscription
    let subscription = CKQuerySubscription(recordType: "joke",
                                           predicate: NSPredicate(value: true),
                                           subscriptionID: identifier,
                                           options: [CKQuerySubscription.Options.firesOnRecordCreation,
                                                     CKQuerySubscription.Options.firesOnRecordUpdate,
                                                     CKQuerySubscription.Options.firesOnRecordDeletion])
    
    subscription.notificationInfo = notificationInfo
    CKContainer.default().publicCloudDatabase.save(subscription,
                                                   completionHandler: ({returnRecord, error in
                                                    if let err = error {
                                                      print("Joke: subscription failed \(err.localizedDescription)")
                                                    } else {
                                                      print("Joke: subscription set up")
                                                    }
                                                   }))
  }
  
}
