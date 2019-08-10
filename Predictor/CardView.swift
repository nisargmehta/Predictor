//
//  CardView.swift
//  Predictor
//
//  Created by Nisarg Mehta on 7/7/19.
//  Copyright © 2019 Open Source. All rights reserved.
//

import UIKit

class CardView: UIView {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    class func instantiate() -> CardView {
        guard let v = Bundle.main.loadNibNamed(String(describing:self), owner: nil, options: nil)?.first as? CardView else {
            fatalError("Failed to load cardview from nib")
        }
        return v
    }
    
    func configure(text: String) {
        self.mainLabel.text = text
    }
}
