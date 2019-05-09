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
        
        FBNetworkController.sharedInstance.login { (success) in
            
        }
        
    }
}
