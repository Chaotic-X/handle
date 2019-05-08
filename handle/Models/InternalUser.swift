//
//  InternalUser.swift
//  handle
//
//  Created by Drew on 5/8/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import Foundation

class InternalUser {
    
    var emailAddress: String?
    var recordsUids: [String]
    let uid: String
    
    var dictionary: [String: Any] {
        return [ InternalUserKey.emailAddress: emailAddress as Any,
                 InternalUserKey.recordsUids: recordsUids,
                 InternalUserKey.uid: uid ]
    }
    
    init(emailAddress: String?, recordsUids: [String], uid: String) {
        
        self.emailAddress = emailAddress
        self.recordsUids = recordsUids
        self.uid = uid
    }
    
    init?(withDict dict: [String: Any]) {
        
        guard let uid = dict[InternalUserKey.uid] as? String,
            let recordsUids = dict[InternalUserKey.recordsUids] as? [String]
            else { print(">>> ❌ \(#file) \(#line): guard let failed <<<"); return nil}
        
        if let emailAddress = dict[InternalUserKey.emailAddress] as? String? {
            self.emailAddress = emailAddress
        }
        
        self.uid = uid
        self.recordsUids = recordsUids
        
    }
}
