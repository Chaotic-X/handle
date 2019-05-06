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
        //.pagesManageCta,

        
        // manager.logIn(readPermissions: [.publicProfile, .email], viewController: self) { (result) in
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
    //
    //    func getUserProfile() {
    //        let connection = GraphRequestConnection()
    //        GraphRequest(graphPath: <#T##String#>, parameters: <#T##[String : Any]#>, tokenString: AccessToken.current?.tokenString, version: <#T##String?#>, httpMethod: <#T##HTTPMethod#>)
    //        connection.add(GraphRequest(graphPath: "/me", parameters:["fields":"id,name,about,birthday"], accessToken: AccessToken.current, httpMethod: .get, apiVersion: .defaultVersion)) {
    //            response, result in
    //            switch result {
    //            case .success(let response):
    //                //                print("😅Logged in user facebook id: \(String(describing: response.dictionaryValue?["id"]))")
    //                //                print("😅Logged in user facebook Name: \(String(describing: response.dictionaryValue?["name"]))")
    //                //                print("😅Logged in user facebook About: \(String(describing: response.dictionaryValue?["about"]))")
    //                //                print("😅Logged in user facebook Birthday: \(String(describing: response.dictionaryValue?["birthday"]))")
    //                break
    //            case .failed(let error):
    //                print("We have an error fetching logged in user profile: \(error.localizedDescription)")
    //            }
    //        }
    //        connection.start()
    //    }
}
//////    @IBAction func shareButtonTapped(_ sender: Any) {
//////        //faceBookShare()
//////        //facebookShare2()
//////        facebookShare3()
//////    }
//////    func faceBookShare()
//////    {
//////
//////        let content:LinkShareContent = LinkShareContent.init(url: URL.init(string: "https://www.facebook.com/holmes.huggins/timeline?lst=1075524270%3A1075524270%3A1555805724") ?? URL.init(fileURLWithPath: "https://developers.facebook.com"), quote: "Share This Content")
//////
//////        let shareDialog = ShareDialog(content: content)
//////        shareDialog.mode = .native
//////        shareDialog.failsOnInvalidData = true
//////        shareDialog.completion = { result in
//////            print("shared successfully")
//////        }
//////        do
//////        {
//////            try shareDialog.show()
//////        }
//////        catch
//////        {
//////            print("Exception")
//////
//////        }
//////    }
//////    func facebookShare2() {
//////
//////        // let manager = LoginManager()
//////        print("share button tapped")
//////
//////        let urlString = "123123"
//////
//////        let content = LinkShareContent(url: URL(string: urlString)!)
//////
//////        let sharer = GraphSharer(content: content)
//////        //sharer.graphNode = "/\(pageId)"
//////
//////        sharer.failsOnInvalidData = true
//////        sharer.completion = {
//////            (result) in
//////
//////            print(result)
//////        }
//////
//////        do {
//////            try sharer.share()
//////        }
//////        catch (let error) {
//////            print(error.localizedDescription)
//////        }
//////
//////    }
//////    func facebookShare3(){
//////
//////        let request = FBSDKGraphRequest(graphPath: "/1285691484917122/feed", parameters: [
//////            "message": "4567889"
//////            ], httpMethod: "POST")
//////        request!.start(completionHandler: { connection, result, error in
//////            //            dump(connection)
//////            //            dump(result)
//////            dump(error)
//////            print(error?.localizedDescription)
//////
//////        })
//////
//////    }
//////
//////
////    
////}
////
