//
//  ViewController.swift
//  twenty-nineteen-cloudkit
//
//  Created by T. Andrew Binkowski on 11/4/19.
//  Copyright © 2019 T. Andrew Binkowski. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController {
  
  //
  // MARK: - Properties
  //
  
  /// Current user's record id
  var userRecordID: CKRecord.ID?

  /// User's name from iCloud
  var userName: String = "" {
    didSet {
      accountLabel.text = self.userName
    }
  }
  
  //
  // MARK: - Outlets and Actions
  //
  
  /// Text label showing the user's account name
  @IBOutlet weak var accountLabel: UILabel!
  
  /// Add a joke to cloudkit
  @IBAction func tapAdd(_ sender: UIButton) {
    CloudKitManager.sharedInstance.addJoke("Why did the student throw a clock out the window?",
                                           response:"She wanted to see time fly.")
  }
  
  /// Retrieve all the jokes
  @IBAction func tapQueryAll(_ sender: UIButton) {
    // Alternative way of using CloudKit API (commented out since we are using the one below)
    //CloudKitManager.sharedInstance.getJokes()
    
    let predicate = NSPredicate(value: true)
    let query = CKQuery(recordType: "joke", predicate: predicate)
    CloudKitManager.sharedInstance.getJokesWithOperation(query: query, cursor: nil)
  }
  
  /// Retrieve all the jokes by a spefic user
  @IBAction func tapQueryUser(_ sender: UIButton) {
    if let userRecordID = self.userRecordID {
      CloudKitManager.sharedInstance.getJokesByCurrentUser(userRecordID)
    } else {
      print("No jokes...")
    }
  }
  
  //
  // MARK: - Lifecycle
  //
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Get the user icloud account based on their signed in Apple Id
    CloudKitManager.sharedInstance.getUserRecordId { (recordID, error) in

      if let userID = recordID?.recordName {
        print("😀 iCloudID: \(userID)")
        self.userRecordID = recordID
        
        // Get user's name now that we have their icloud acccount id
        // We are nesting this because we have to wait for the record to
        // return before we can send it out for the name
        CloudKitManager.sharedInstance.getUserIdentity(userRecordID: self.userRecordID,
                                                       complete: { (record, error) in
          DispatchQueue.main.async {
            self.userName = record!.description
          }
        }
        )
      } else {
        print("😢 We could not get the user's record id. iCloudID = nil")
      }
    }
  }
  
}

