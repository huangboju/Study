//
//  GamePickerViewController.swift
//  Ratings
//
//  Created by 伯驹 黄 on 2017/4/7.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class GamePickerViewController: UITableViewController {

    var games: [String]!

    var selectedGame: String?
    var selectedGameIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        games = ["Angry Birds",
                 "Chess",
                 "Russian Roulette",
                 "Spin the Bottle",
                 "Texas Hold'em Poker",
                 "Tic-Tac-Toe"]
        
        if let game = selectedGame {
            selectedGameIndex = find(game)
        }
    }
    
    func find(_ str: String) -> Int? {
        for (i, game) in games.enumerated() where game == str {
            return i
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath)

        if indexPath.row == selectedGameIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        cell.textLabel?.text = games[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveSelectedGame" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            selectedGameIndex = indexPath?.row
            if let index = selectedGameIndex {
                selectedGame = games[index]
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        //Other row is selected - need to deselect it
        if let index = selectedGameIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }

        selectedGameIndex = indexPath.row
        selectedGame = games[indexPath.row]

        //update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
}
