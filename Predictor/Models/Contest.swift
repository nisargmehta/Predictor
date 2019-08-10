//
//  Contest.swift
//  Predictor
//
//  Created by Nisarg Mehta on 7/7/19.
//  Copyright © 2019 Open Source. All rights reserved.
//

import Foundation
import Firebase

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
            let date = dictionary["timestamp"] as? Timestamp
            else { return nil }
        
        self.init(name: name, addedByUser: addedByUser, status: status, date: date.dateValue())
    }
    
}

struct Question {
    var title: String
    var imageUrl: String
    var answer: String
    
    var dictionary: [String: Any] {
        return [
            "title": title,
            "imageUrl": imageUrl,
            "answer": answer
        ]
    }
}

extension Question: DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let title = dictionary["title"] as? String,
            let imageUrl = dictionary["imageUrl"] as? String,
            let answer = dictionary["answer"] as? String else { return nil }
        
        self.init(title: title, imageUrl: imageUrl, answer: answer)
    }
}
