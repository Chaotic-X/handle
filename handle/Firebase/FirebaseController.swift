////
////  FirebaseController.swift
////  handle
////
////  Created by Drew on 5/6/19.
////  Copyright © 2019 Alex Lundquist. All rights reserved.
////
//
//import Foundation
//import Firebase
//
//class FirebaseController {
//    
//    static let db = Firestore.firestore()
//    
//    static var ref: DocumentReference? = nil
//    
//    static func fetch(fromRef ref: DocumentReference, completion: @escaping (DocumentSnapshot?) -> Void) {
//        ref.getDocument(completion: { (snapshot, error) in
//            if let error = error {
//                print(">>>>>>> There was an error in \(#file): \(#function): \(#line) \(error) \(error.localizedDescription) <<<<<<<")
//                completion(nil)
//                return
//            }
//            guard let snapshot = snapshot else { print(">>>\(#file) \(#line): guard let failed<<<"); completion(nil); return }
//            completion(snapshot)
//        })
//    }
//    
//    /**
//     Fetches data with a given query
//     Query example:
//     FirebaseController.db.collection("users").whereField("uid", isEqualTo: uid)
//     Reference: https://firebase.google.com/docs/firestore/query-data/queries
//     Completion: non-optional array of QueryDocumentSnapshot
//     */
//    static func fetch(withQuery query: Query, completion: @escaping ([QueryDocumentSnapshot]) -> ()) {
//        query.getDocuments { (snapshot, error) in
////            print(snapshot)
//            if let error = error {
//                print(">>>>>>> There was an error in \(#file): \(#function): \(#line) \(error) \(error.localizedDescription) <<<<<<<")
//                completion([])
//                return
//            }
//            
//            guard let snapshot = snapshot,
//                !snapshot.isEmpty
//                else { print(">>>\(#file) \(#line): guard let failed<<<"); completion([]); return }
//            
//            let data = snapshot.documents
//            completion(data)
//        }
//    }
//    
//    /**
//     Saves object in the form of dictionary to FireStore
//     - Parameters:
//     - objectDict: [String : Any] map of the object
//     - to: DocumentReference -  FireStore Document reference
//     (example : FirebaseController.db.collection("<someColleciton>").document("<someDocument
//     */
//    static func save(objectDict: [String: Any], to ref: DocumentReference, completion: @escaping (Bool) ->()) {
//        
//        //        let objDict = ObjectHelper.convertObjectToDict(objectDict)
//        
//        ref.setData(objectDict, completion: { (error) in
//            if let error = error {
//                print(">>>>>>> There was an error in \(#file): \(#function): \(#line) \(error) \(error.localizedDescription) <<<<<<<");
//                completion(false);
//                return
//            }
//            completion(true)
//        })
//    }
//    
//    static func delete(fromRef ref: DocumentReference, completion: @escaping (Bool) -> Void) {
//        ref.delete { (error) in
//            if let error = error {
//                print(">>>>>>> There was an error in \(#file): \(#function): \(#line) \(error) \(error.localizedDescription) <<<<<<<")
//                completion(false)
//                return
//            }
//        }
//    }
//}
