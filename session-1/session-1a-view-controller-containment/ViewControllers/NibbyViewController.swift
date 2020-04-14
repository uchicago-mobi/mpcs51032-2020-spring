//
//  NibbyViewController.swift
//  ViewControllers
//
//  Created by T. Andrew Binkowski on 4/3/17.
//  Copyright © 2017 The University of Chicago, Department of Computer Science. All rights reserved.
//

import UIKit

class NibbyViewController: UIViewController {

  @IBAction func tapButton(_ sender: UIButton) {
    print("tapButton")
    
    self.dismiss(animated: true) {
      print("Dismissed Nibby")
    }
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
