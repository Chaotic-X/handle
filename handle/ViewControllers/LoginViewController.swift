////
////  LoginViewController.swift
////  handle
////
////  Created by Ben Huggins on 5/4/19.
////  Copyright © 2019 Alex Lundquist. All rights reserved.
////
//
import UIKit

class LoginViewController: UIViewController {
    
    var accessTokens2: String = ""
    var pageIds2: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        
        FBNetworkController.sharedInstance.login { (success) in
            
        }
  
    }
}
