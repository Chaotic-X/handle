//
//  ProfileViewController.swift
//  handle
//
//  Created by Ben Huggins on 5/6/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   

    
    @IBOutlet weak var profileTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    // show the user their Pages
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return FBNetworkController.sharedInstance.namesOfPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "pagesCell", for: indexPath)
        
        cell.textLabel?.text = FBNetworkController.sharedInstance.namesOfPages[indexPath.row]
        return cell
    }
    
    
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
