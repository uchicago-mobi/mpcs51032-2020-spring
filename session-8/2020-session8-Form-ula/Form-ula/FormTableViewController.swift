//
//  FormTableViewController.swift
//  Form-ula
//
//  Created by T. Andrew Binkowski on 3/5/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//
//https://medium.com/@KaushElsewhere/how-to-dismiss-keyboard-in-a-view-controller-of-ios-3b1bfe973ad1
import UIKit

class FormTableViewController: UITableViewController {
  
  @IBOutlet weak var firstNameField: UITextField!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var dataTextView: UITextView!
  @IBOutlet weak var contactUser: UISwitch!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.firstNameField.delegate = self
    self.emailField.delegate = self
    self.tableView.keyboardDismissMode = .onDrag

    // Automatically show/hide keyboard
    firstNameField.becomeFirstResponder()
  }
  
  @IBAction func newProductSwitch(_ sender: UISwitch) {
    print("switch: \(sender.isOn) 3002 #2")
  }
  
  // Dismiss Keyboard #2
  @IBAction func tapTable(_ sender: UITapGestureRecognizer) {
    print("Tap")
    firstNameField.resignFirstResponder()
  }
  
  @IBAction func textChanged(_ sender: UITextField) {
    print(sender)
    print(sender.text!)
  }
  
  func validateEmail(_ email: String) -> Bool {
    if (email == "test@test.com") {
      return true
    }
    return false
  }
}

/// UITextFieldDelegate

extension FormTableViewController: UITextFieldDelegate {
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    print("Did End Editing: \(textField.text!)")
    
    switch textField {
    case self.firstNameField:
      print("First:")
      
    case self.emailField:
      print("Email:")
      let valid = validateEmail(textField.text!)
    default:
      print("Can't find field")
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
  
}
