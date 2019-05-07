//
//  SelectPhotoViewController.swift
//  handle
//
//  Created by Alex Lundquist on 5/2/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource  {
    
    
    @IBOutlet weak var captionTextField: UITextField!
    
    @IBOutlet weak var fbPagesTableView: UITableView!
    
    var selectedImage: UIImage?
    var pageNames: [String] = []
    var postObject: PostContent?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionTextField.delegate = self
        
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        selectedImage = nil
        captionTextField.text = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("AAAAAAAAAAAAAAA")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FBNetworkController.sharedInstance.namesOfPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fbPagesTableView.dequeueReusableCell(withIdentifier: "pagesCell", for: indexPath) as? PagesSelectTableViewCell
        
        cell?.pageSelectCellLandingPad = FBNetworkController.sharedInstance.namesOfPages[indexPath.row]
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPhotoSelector" {
            let photoSelector = segue.destination as? PhotoSelectorViewController
            photoSelector?.delegate = self
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func postToFBbuttonTapped(_ sender: UIButton) {
        guard let photoToPost = selectedImage,
            !pageNames.isEmpty,
            let caption = captionTextField.text,
            !caption.isEmpty else {
                return
        }
        postObject = StaticContent.shared.createPost(caption: caption, crPhoto: photoToPost)
        guard let postObject1 = postObject else {return}
        FBNetworkController.sharedInstance.postToDesiredFBPages(pageNames: pageNames, postObject: postObject1)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectPhotoCancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SelectPhotoViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage) {
        captionTextField.resignFirstResponder()
        selectedImage = image
        
        // NEED TO SEND THIS TO FBNETWORK CONTROLLER TO MAKE THE POST
        
    }
}

// Passes back the name of the FB page that was selected 
extension SelectPhotoViewController: PagesSelectTableViewCellDelegate {
    func pageToggleSelected(_ sender: PagesSelectTableViewCell) {
        
        print("toggle was selected👄👄👄👄👄👄👄👄👄👄")
        guard let pageName = sender.pageSelectCellLandingPad else {return}
        if sender.pagesToggle.isOn {
            pageNames.append(pageName)
        } else {
            if pageNames.contains(pageName) {
                guard let index = pageNames.firstIndex(of: pageName) else { return }
                pageNames.remove(at: index)
            }
        }
    }
}
