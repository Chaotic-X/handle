//
//  PostScheduleViewController.swift
//  handle
//
//  Created by Alex Lundquist on 5/2/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import UIKit

class PostScheduleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  @IBAction func postScheduleCancel(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  @IBAction func schedulePostButtonTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  @IBAction func postNowButtonTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  
  
}
