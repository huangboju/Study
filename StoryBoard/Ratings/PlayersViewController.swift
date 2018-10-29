//
//  PlayersViewController.swift
//  Ratings
//
//  Created by 伯驹 黄 on 2017/4/7.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class PlayersViewController: UITableViewController {
    
    var players: [Player] = playersData

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerCell

        let player = players[indexPath.row]

        cell?.nameLabel.text = player.name
        cell?.gameLabel.text = player.game
        cell?.ratingImageView.image = image(for: player.rating)
        return cell!
    }

    func image(for rating: Int) -> UIImage? {
        switch rating {
        case 1:
            return UIImage(named: "1StarSmall")
        case 2:
            return UIImage(named: "2StarsSmall")
        case 3:
            return UIImage(named: "3StarsSmall")
        case 4:
            return UIImage(named: "4StarsSmall")
        case 5:
            return UIImage(named: "5StarsSmall")
        default:
            return nil
        }
    }

    @IBAction func cancelToPlayersViewController(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func savePlayerDetail(segue: UIStoryboardSegue) {
        let playerDetailsViewController = segue.source as! PlayerDetailsViewController

        //add the new player to the players array
        players.append(playerDetailsViewController.player)

        //update the tableView
        let indexPath = IndexPath(row: players.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        //hide the detail view controller
        dismiss(animated: true, completion: nil)
    }
}
