import UIKit
import FacebookLogin
import FacebookCore
import FacebookShare
=======

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
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        
        FBNetworkController.sharedInstance.login { (success) in
            
        }
        
    }
}
