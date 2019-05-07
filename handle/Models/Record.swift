//
//  Record.swift
//  handle
//
//  Created by Drew on 5/6/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import UIKit

class Record {
    
    var message: String
    let creatorUid: String
    let creationTimestamp: TimeInterval
    let postingTimestamp: TimeInterval
    var imageUrl: String?
    weak var image: UIImage?
    let uid: String
    
    var dictionary: [String: Any] {
        return [ RecordKey.message : message,
                 RecordKey.creatorUid: creatorUid,
                 RecordKey.creationTimestamp: creationTimestamp,
                 RecordKey.postingTimestamp: postingTimestamp,
                 RecordKey.imageUrl: imageUrl as Any,
                 RecordKey.uid: uid ]
    }
    
    init(message: String, creatorUid: String, creationTimestamp: TimeInterval = Date().timeIntervalSince1970, postingTimestamp: TimeInterval, imageUrl: String?, uid: String ) {
        
        self.message = message
        self.creatorUid = creatorUid
        self.creationTimestamp = creationTimestamp
        self.postingTimestamp = postingTimestamp
        self.imageUrl = imageUrl
        self.uid = uid
    }
    
    init?(withDict dict: [String: Any]) {
        guard let message = dict[RecordKey.message] as? String,
            let creatorUid = dict[RecordKey.creatorUid] as? String,
            let creationTimestamp = dict[RecordKey.creationTimestamp] as? TimeInterval,
            let postingTimestamp = dict[RecordKey.postingTimestamp] as? TimeInterval,
            let uid = dict[RecordKey.uid] as? String
        else { fatalError(">>> ❌ \(#file) \(#line): guard let failed <<<"); return nil}
        
        if let imageUrl = dict[RecordKey.imageUrl] as? String? {
            self.imageUrl = imageUrl
        }
        
        self.message = message
        self.creatorUid = creatorUid
        self.creationTimestamp = creationTimestamp
        self.postingTimestamp = postingTimestamp
        self.uid = uid
    }
}
