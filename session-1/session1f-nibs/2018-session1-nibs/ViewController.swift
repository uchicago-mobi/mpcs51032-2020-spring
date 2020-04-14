//
//  ViewController.swift
//  2018-session1-nibs
//
//  Created by T. Andrew Binkowski on 4/1/18.
//  Copyright © 2018 T. Andrew Binkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  
  @IBAction func tapGotoPink(_ sender: UIButton) {
  let vc = PinkViewController()
  self.present(vc, animated: true, completion: nil)
  }

  @IBAction func tapSegue(_ sender: UIButton) {
    let vc = PinkViewController()
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}

