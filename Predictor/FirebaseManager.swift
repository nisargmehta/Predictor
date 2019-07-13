//
//  FirebaseManager.swift
//  Predictor
//
//  Created by Nisarg Mehta on 7/5/19.
//  Copyright © 2019 Open Source. All rights reserved.
//

import UIKit
import FirebaseFirestore

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
    
    // contest
    func contestQuery() -> Query {
        let firestore: Firestore = Firestore.firestore()
        return firestore.collection("Contests").limit(to: 10)
    }
    
    private func handleSnapshot(snapshot: QuerySnapshot?, error: Error?) {
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
    
    func getContestData() {
        self.contestQuery().getDocuments { (snapshot, error) in
            self.handleSnapshot(snapshot: snapshot, error: error)
        }
    }
    
    func listenToContestChanges() {
        self.contestQuery().addSnapshotListener { (snapshot, error) in
            self.handleSnapshot(snapshot: snapshot, error: error)
        }
        
    }
    
    
}
