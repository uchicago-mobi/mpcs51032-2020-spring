//
//  ViewController.swift
//  2020-localization
//
//  Created by T. Andrew Binkowski on 6/2/20.
//  Copyright © 2020 T. Andrew Binkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var localizedLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    let greeting = NSLocalizedString("GREETING", comment: "Casual greeting to friends")
    
    self.localizedLabel.text = greeting
  }


}

