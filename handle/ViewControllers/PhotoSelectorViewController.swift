//
//  PhotoSelectorViewController.swift
//  handle
//
//  Created by Alex Lundquist on 5/4/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import UIKit

class PhotoSelectorViewController: UIViewController {

  @IBOutlet weak var selectPhotoButton: UIButton!
  @IBOutlet weak var selectImageView: UIImageView!
  
  weak var delegate: PhotoSelectorViewControllerDelegate?
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    selectImageView.image = nil
    selectPhotoButton.setTitle("Select a Photo to Post", for: .normal)
  }
  @IBAction func selectPhotoButtonTapped(_ sender: UIButton){
    presentImagePickerActionSheet()
  }
}//end of class

//MARK: -Extensions
extension PhotoSelectorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    picker.dismiss(animated: true, completion: nil)
    if let photo = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      selectPhotoButton.setTitle("", for: .normal)
      selectImageView.image = photo
      delegate?.photoSelectorViewControllerSelected(image: photo)
    }
  }//End of Func
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }//End of Func
  func presentImagePickerActionSheet(){
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    let actionSheet = UIAlertController(title: "Select a Photo", message: nil, preferredStyle: .actionSheet)
    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
      actionSheet.addAction(UIAlertAction(title: "Photo", style: .default, handler: { (_) in
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
      }))
    }
    actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    present(actionSheet, animated: true)
  }
}//End of Extension

//MARK: -Protocol
protocol PhotoSelectorViewControllerDelegate: class {
  func photoSelectorViewControllerSelected(image: UIImage)
}
