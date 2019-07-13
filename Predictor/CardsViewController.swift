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
    var allCardsData:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateStaticData()
        kolodaView.dataSource = self
        kolodaView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func populateStaticData() {
        self.allCardsData = ["First card", "Second card!!", "last card?"]
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        print("selected koloda view")
    }
    
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return allCardsData.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let view = CardView.instantiate()
        view.configure(text: allCardsData[index])
        view.frame = koloda.frame
        return view
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("CustomOverlay", owner: self, options: nil)?[0] as? CustomOverlay
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        // collect data
        
    }
    
    @IBAction func yesActionTapped() {
        kolodaView.swipe(.right)
    }
    
    @IBAction func noActionTapped() {
        kolodaView.swipe(.left)
    }
}
