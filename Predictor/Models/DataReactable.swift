//
//  DataReactable.swift
//  Predictor
//
//  Created by Nisarg Mehta on 7/7/19.
//  Copyright © 2019 Open Source. All rights reserved.
//

import Foundation

protocol DataReactable: AnyObject {
    func dataChanged<T>(data: [T]) where T:DocumentSerializable
}

struct WeakDataDelegate {
    weak var weakReference: DataReactable?
}

protocol DocumentSerializable {
    init?(dictionary: [String: Any])
}
