//
//  HomeTableViewController.swift
//  Predictor
//
//  Created by Nisarg Mehta on 7/5/19.
//  Copyright © 2019 Open Source. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, DataReactable {
    
    var allContests: [Contest] = []
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        FirebaseManager.shared.addObserver(self)
        FirebaseManager.shared.getContestData()
    }

    deinit {
        FirebaseManager.shared.removeObserver(self)
    }
    
    func dataChanged<T>(data: [T]) where T : DocumentSerializable {
        if let contests = data as? [Contest] {
            self.allContests = contests
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allContests.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contestCell", for: indexPath)
        cell.textLabel?.text = allContests[indexPath.row].name
        cell.detailTextLabel?.text = allContests[indexPath.row].status
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        performSegue(withIdentifier: "cardsSegue", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardsSegue" {
            if let controller = segue.destination as? CardsViewController, let index = selectedIndex {
                print("going to cards with index: \(index)")
            }
        }
    }

}
