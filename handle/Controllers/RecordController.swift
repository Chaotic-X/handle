//
//  RecordController.swift
//  handle
//
//  Created by Drew on 5/7/19.
//  Copyright © 2019 Alex Lundquist. All rights reserved.
//

import Foundation

class RecordController {
    
    static let shared = RecordController(); private init() {}
    
    var records : [Record] = []
    
    func createRecord(message: String, creatorUid: String, postingTimestamp: TimeInterval, imageUrl: String?, completion: @escaping (Record?) -> Void) {
        
        let dbref = FirebaseController.db.collection("records").document()
        
        let newRecord = Record(message: message, creatorUid: creatorUid, postingTimestamp: postingTimestamp, imageUrl: imageUrl, uid: dbref.documentID)
        
        FirebaseController.save(objectDict: newRecord.dictionary, to: dbref) { (success) in
            if success {
                self.records.append(newRecord)
                completion(newRecord)
            } else {
                completion(nil)
            }
        }
    }
    
    func fetchRecord(withId recordId: String, completion: @escaping (Record?) -> Void) {
        
        let query = FirebaseController.db.collection("records").document(recordId)
        query.getDocument { (snapshot, error) in
            if let error = error {
                print(">>>>>>> There was an error in \(#file): \(#function): \(#line) \(error) \(error.localizedDescription) <<<<<<<")
                completion(nil)
                return
            }
            guard let snapshot = snapshot,
                let snapshotData = snapshot.data()
                else { print(">>>\(#file) \(#line): guard let failed<<<"); completion(nil); return }
            
            let record = Record(withDict: snapshotData)
            completion(record)
        }
    }
    
    func fetchRecords(withDateRangeStartingAt starting: TimeInterval, ending: TimeInterval, forCreatorUid uid: String, completion: @escaping ([Record]) -> Void) {
        
        let query = FirebaseController.db.collection("records").whereField("creatorUid", isEqualTo: uid).whereField("postingTimestamp", isGreaterThanOrEqualTo: starting).whereField("postingTimestamp", isLessThanOrEqualTo: ending)
        
        FirebaseController.fetch(withQuery: query) { (recordsQuery) in
            if !recordsQuery.isEmpty {
                let records = recordsQuery.compactMap{ Record(withDict: $0.data())}
                completion(records)
            } else {
                completion([])
            }
        }
    }
    
    func updateRecord(_ record: Record, completion: @escaping (Record?) -> Void) {
        
        let dbref = FirebaseController.db.collection("records").document(record.uid)
        
        FirebaseController.save(objectDict: record.dictionary, to: dbref) { (success) in
            completion(success ? record : nil)
        }
    }
    
    func deleteRecord(_ record: Record, completion: @escaping (Bool) -> Void) {
        FirebaseController.db.collection("records").document(record.uid).delete() { (error) in
            if let error = error {
                print(">>>>>>> There was an error in \(#file): \(#function): \(#line) \(error) \(error.localizedDescription) <<<<<<<")
                completion(false)
                return
            }
            completion(true)
            print("Deleted successfully")
        }
    }
    
}

