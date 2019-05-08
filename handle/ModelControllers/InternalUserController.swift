//
//  InternalUserController.swift
//  handle
//
//  Created by Drew on 5/8/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import Foundation

class InternalUserController {
    
    static let shared = InternalUserController(); private init() {}
    
    var loggedInUser : InternalUser?
    
    func createUser(emailAddress: String, password: String, completion: @escaping (InternalUser?)->()){
        FirebaseLoginController.signUpNewUser(withEmail: emailAddress, password: password) { (authorizedUser) in
            guard let authorizedUser = authorizedUser else { print(">>>\(#file) \(#line): guard let failed<<<"); completion(nil); return }
            
            let newUser = InternalUser(emailAddress: emailAddress, recordsUids: [], uid: authorizedUser.uid)
            let dbref = FirebaseController.db.collection("users").document(authorizedUser.uid)
            
            FirebaseController.save(objectDict: newUser.dictionary, to: dbref, completion: { (success) in
                if success {
                    self.loggedInUser = newUser
                    completion(newUser)
                }
            })
        }
    }
    
    func loginUser(withEmail email: String, password: String, completion: @escaping (InternalUser?) -> Void) {
        FirebaseLoginController.signInUser(withEmail: email, password: password) { (user) in
            if let user = user {
                InternalUserController.shared.fetchUser(withUid: user.uid, completion: { (iuser) in
                    if let iuser = iuser {
                        completion(iuser)
                    }
                })
            }
        }
    }
    
    /// Call on firebase manager to log out.
    /// sets self.loggedInUser = nil (logging out logged in user)
    func logOut() {
        
        FirebaseLoginController.signOutUser()
        self.loggedInUser = nil
    }
    
    private func updateUser(_ user: InternalUser, completion: @escaping (InternalUser?) -> Void) {
        
        let dbref = FirebaseController.db.collection("users").document(user.uid)
        FirebaseController.save(objectDict: user.dictionary, to: dbref) { (success) in
            if success {
                completion(user)
            } else {
                completion(nil)
            }
        }
    }
    
    func signIn(emailAddress: String, password: String, completion: @escaping (Bool) -> Void) {
        
        FirebaseLoginController.signInUser(withEmail: emailAddress, password: password) { (authorizedUser) in
            guard let authorizedUser = authorizedUser else { print(">>>\(#file) \(#line): guard let failed<<<"); completion(false); return }
            let dbref = FirebaseController.db.collection("users").document(authorizedUser.uid)
            
            FirebaseController.fetch(fromRef: dbref, completion: { (snapshot) in
                guard let snapshotData = snapshot?.data() else { print(">>>\(#file) \(#line): guard let failed<<<"); completion(false); return }
                self.loggedInUser = InternalUser(withDict: snapshotData)
                completion(true)
            })
        }
    }
    
    func fetchUser(withUid uid: String, completion: @escaping (InternalUser?) -> Void) {
        let query = FirebaseController.db.collection("users").whereField("uid", isEqualTo: uid)
        FirebaseController.fetch(withQuery: query) { (snapshots) in
            if !snapshots.isEmpty {
                let user = InternalUser(withDict: snapshots[0].data())
                completion(user)
            } else {
                completion(nil)
            }
        }
    }
}
