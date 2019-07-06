//
//  FirebaseManager.swift
//  Predictor
//
//  Created by Nisarg Mehta on 7/5/19.
//  Copyright © 2019 Open Source. All rights reserved.
//

import UIKit
import Firebase

struct Contest {
    let key: String
    let name: String
    let addedByUser: String
    var status: String
}

class FirebaseManager {
    static let shared = FirebaseManager()
    
}
