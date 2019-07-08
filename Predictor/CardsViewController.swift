//
//  CardsViewController.swift
//  Predictor
//
//  Created by Nisarg Mehta on 7/7/19.
//  Copyright © 2019 Open Source. All rights reserved.
//

import UIKit
import Koloda

class CardsViewController: UIViewController, KolodaViewDataSource, KolodaViewDelegate {

    @IBOutlet weak var kolodaView: KolodaView!
    var allCards:[UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        print("selected koloda view")
    }
    
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return allCards.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return self.allCards[index]
    }
    
//    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
//        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)[0] as? OverlayView
//    }
}
