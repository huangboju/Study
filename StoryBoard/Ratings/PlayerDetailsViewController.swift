//
//  PlayerDetailsViewController.swift
//  Ratings
//
//  Created by 伯驹 黄 on 2017/4/7.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var detailLabel: UILabel!

    var player: Player!

    var game = "Chess"

    override func viewDidLoad() {
        super.viewDidLoad()
        detailLabel.text = game
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SavePlayerDetail" {
            player = Player(name: nameTextField.text!, game: game, rating: 1)
        }
        if segue.identifier == "PickGame" {
            let gamePickerViewController = segue.destination as! GamePickerViewController
            gamePickerViewController.selectedGame = game
        }
    }

    @IBAction func selectedGame(segue: UIStoryboardSegue) {
        let gamePickerViewController = segue.source as! GamePickerViewController
        if let selectedGame = gamePickerViewController.selectedGame {
            detailLabel.text = selectedGame
            game = selectedGame
        }
        _ = navigationController?.popViewController(animated: true)
    }

    required init?(coder aDecoder: NSCoder) {
        print("init PlayerDetailsViewController")
        super.init(coder: aDecoder)!
    }

    deinit {
        print("deinit PlayerDetailsViewController")
    }
}
