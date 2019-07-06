//
//  FirebaseManager.swift
//  Predictor
//
//  Created by Nisarg Mehta on 7/5/19.
//  Copyright © 2019 Open Source. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

protocol DataReactable: AnyObject {
    func dataChanged<T>(data: [T]) where T:DocumentSerializable
}

struct WeakDataDelegate {
    weak var weakReference: DataReactable?
}

protocol DocumentSerializable {
    init?(dictionary: [String: Any])
}

struct Contest {
    
    var name: String
    var addedByUser: String
    var status: String
    var date: Date
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "addedByUser": addedByUser,
            "status": status,
            "timestamp": date
        ]
    }
    
}

extension Contest: DocumentSerializable {
    
    init?(dictionary: [String : Any]) {
        guard let name = dictionary["name"] as? String,
            let addedByUser = dictionary["addedByUser"] as? String,
            let status = dictionary["status"] as? String,
            let date = dictionary["timestamp"] as? Timestamp else { return nil }
        
        self.init(name: name, addedByUser: addedByUser, status: status, date: date.dateValue())
    }
    
}

class FirebaseManager {
    static let shared = FirebaseManager()
    
    var observers = [WeakDataDelegate]()
    
    func addObserver(_ delegate: DataReactable) {
        observers = observers.filter { $0.weakReference != nil && $0.weakReference !== delegate }
        observers.append(WeakDataDelegate(weakReference: delegate))
    }
    
    func removeObserver(_ delegate: DataReactable) {
        observers = observers.filter { $0.weakReference != nil && $0.weakReference !== delegate }
    }
    
    func contestQuery() -> Query {
        let firestore: Firestore = Firestore.firestore()
        return firestore.collection("Contests").limit(to: 10)
    }
    
    func getContestData() {
        self.contestQuery().getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(error!)")
                return
            }
            let models = snapshot.documents.map { (document) -> Contest in
                if let model = Contest(dictionary: document.data()) {
                    return model
                } else {
                    // Don't use fatalError here in a real app.
                    fatalError("Unable to initialize type \(Contest.self) with dictionary \(document.data())")
                }
            }
            
            for observer in self.observers {
                observer.weakReference?.dataChanged(data: models)
            }
        }
    }
    
    func listenToContestChanges() {
        self.contestQuery().addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("Error fetching snapshot results: \(error!)")
                return
            }
            let models = snapshot.documents.map { (document) -> Contest in
                if let model = Contest(dictionary: document.data()) {
                    return model
                } else {
                    // Don't use fatalError here in a real app.
                    fatalError("Unable to initialize type \(Contest.self) with dictionary \(document.data())")
                }
            }
            
            for observer in self.observers {
                observer.weakReference?.dataChanged(data: models)
            }
        }
        
    }
}
