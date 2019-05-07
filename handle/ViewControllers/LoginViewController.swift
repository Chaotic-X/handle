////
////  LoginViewController.swift
////  handle
////
////  Created by Ben Huggins on 5/4/19.
////  Copyright © 2019 Alex Lundquist. All rights reserved.
////
//
import UIKit
import FacebookLogin
import FacebookCore
import FacebookShare

class LoginViewController: UIViewController {
    
    var accessTokens2: String = ""
    var pageIds2: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        let manager = LoginManager()
        
        manager.logIn(publishPermissions: [.managePages, .publishPages], viewController: self) { (result) in
            
            switch result {
            case .cancelled:
                print("User cancelled Login")
                break
            case .failed(let error):
                print("Login failed with error = \(error.localizedDescription)")
                break
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                // print("access token: \(accessToken)")
                // print("😍")
                
                let test2 = "\(accessToken.authenticationToken)"
                print("👻👻👻👻👻👻")
                print(accessToken.authenticationToken)
                
                FBNetworkController.sharedInstance.accessToken1 = test2
                
                // this fetch returns the pageId and
                
                // here we get the names of the pages
                FBNetworkController.sharedInstance.getPageIDWithUserAccessToken(completion: { (accessTokens, namesOfPages, pageIds) in
                    
                    // here we are assigning our return values to a global varible to be called
                    //  accessToken = accessTokens2
                    
                    print("🤢🤢🤢🤢🤢🤢🤢")
                    print(accessTokens)
                    print(namesOfPages)
                    print(pageIds)
      
                    FBNetworkController.sharedInstance.getPageTokenWithPageID(accessToken: accessTokens.first!, pageID: pageIds.first!, completion: { (pageAccessToken, idSame) in
                        print("🎃🎃🎃🎃🎃🎃🎃")
                        print(pageAccessToken)
                        print(idSame)
                        
                        //pass pageToken and idSame
                        
                        FBNetworkController.sharedInstance.postToFaceBookWithPageToken(value: "http://593develop.com/ben/video.MP4", pageAcessToken: pageAccessToken, idSame: idSame, completion: { (succes) in
                            print("YO THIS MEANS I AM POSTING WITH XCODE ")
                        })
                    })
                })
            }
        }
    }

}
