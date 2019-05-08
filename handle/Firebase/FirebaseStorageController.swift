//
//  FirebaseStorageController.swift
//  handle
//
//  Created by Drew on 5/6/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class FirebaseStorageController {
    
    private static let storageRef = Storage.storage().reference()
    
    // Uploads image with user.uid as imagepath, comletion: image url as String

//    static func uploadImage(_ image: UIImage, forUser user: InternalUser, completion: @escaping (String?) -> Void) {
//
//        let ref = storageRef.child(user.uid)
//        let compressedImage = image.jpegData(compressionQuality: 0.2)
//        if let uploadData = compressedImage {
//            ref.putData(uploadData, metadata: nil) { (metadata, error) in
//                if let error = error {
//                    print(">>> There was an error in \(#file): \(#line): \(error) \(error.localizedDescription) <<<")
//                    completion(nil)
//                    return
//                }
//
//                guard let _ = metadata else { print(">>>\(#file) \(#line): guard let failed <<<"); completion(nil); return }
//
//                ref.downloadURL(completion: { (url, error) in
//                    if let error = error {
//                        print(">>> There was an error in \(#file): \(#line): \(error) \(error.localizedDescription) <<<")
//                        completion(nil)
//                        return
//                    }
//
//                    guard let url = url else { print(">>>\(#file) \(#line): guard let failed <<<"); completion(nil); return }
//
//                    completion(url.absoluteString)
//                })
//            }
//        }
//    }
//
//    static func fetchImage(forUser user: InternalUser, completion: @escaping (UIImage?) -> Void) {
//
//        let ref = storageRef.child(user.uid)
//        ref.getData(maxSize: 1 * 10024 * 10024) { (data, error) in
//            if let error = error {
//                print(">>> There was an error in \(#file): \(#line): \(error) \(error.localizedDescription) <<<")
//                completion(nil)
//            }
//
//            guard let data = data,
//                let image = UIImage(data: data)
//                else { print(">>>\(#file) \(#line): guard let failed <<<"); completion(nil); return }
//
//            completion(image)
//        }
//    }
//}
//

    static func uploadImage(_ image: UIImage, forUser user: InternalUser, completion: @escaping (String?) -> Void) {

        let ref = storageRef.child(user.uid)
        let compressedImage = image.jpegData(compressionQuality: 0.2)
        if let uploadData = compressedImage {
            ref.putData(uploadData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print(">>> There was an error in \(#file): \(#line): \(error) \(error.localizedDescription) <<<")
                    completion(nil)
                    return
                }

                guard let _ = metadata else { print(">>>\(#file) \(#line): guard let failed <<<"); completion(nil); return }

                ref.downloadURL(completion: { (url, error) in
                    if let error = error {
                        print(">>> There was an error in \(#file): \(#line): \(error) \(error.localizedDescription) <<<")
                        completion(nil)
                        return
                    }

                    guard let url = url else { print(">>>\(#file) \(#line): guard let failed <<<"); completion(nil); return }

                    completion(url.absoluteString)
                })
            }
        }
    }
    
    static func fetchImage(forUser user: InternalUser, completion: @escaping (UIImage?) -> Void) {

        let ref = storageRef.child(user.uid)
        ref.getData(maxSize: 1 * 10024 * 10024) { (data, error) in
            if let error = error {
                print(">>> There was an error in \(#file): \(#line): \(error) \(error.localizedDescription) <<<")
                completion(nil)
            }

            guard let data = data,
                let image = UIImage(data: data)
                else { print(">>>\(#file) \(#line): guard let failed <<<"); completion(nil); return }

            completion(image)
        }
    }

}
