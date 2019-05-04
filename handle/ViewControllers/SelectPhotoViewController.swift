//
//  SelectPhotoViewController.swift
//  handle
//
//  Created by Alex Lundquist on 5/2/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController, UITextFieldDelegate  {
  @IBOutlet weak var captionTextField: UITextField!
  var selectedImage: UIImage?
  var postObject: [PostContent]?
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.delegate = self
      
    }
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    selectedImage = nil
    captionTextField.text = nil
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
      let caption = captionTextField.text,
      !caption.isEmpty else {
        return
    }
    postObject = StaticContent.shared.createPost(caption: caption, crPhoto: photoToPost)
   self.dismiss(animated: true, completion: nil)
  }
  @IBAction func selectPhotoCancelTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
}//End of Class

//MARK: -Extensions

extension SelectPhotoViewController: PhotoSelectorViewControllerDelegate {
  func photoSelectorViewControllerSelected(image: UIImage) {
    captionTextField.resignFirstResponder()
    selectedImage = image
  }
}//End of Extension
