//
//  ViewController.swift
//  AVPlayerStudy
//
//  Created by 黄伯驹 on 2017/8/2.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let player = AVQueuePlayer()

    var currentMusic = "Beat It"

    lazy var data: [[String]] = [
        [
            "BillieJean",
            "Beat It",
            "Baby Be Mine"
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "AVQueuePlayer"
        
        view.addSubview(tableView)

        initPlayer()

        initQueuePlayer()
    }
    
    func initQueuePlayer() {
        let items = [
            "Voyeur_Sting",
            "BillieJean",
            "Beat It",
            "Baby Be Mine"
            ].flatMap {
                AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: $0, ofType: "mp3")!))
        }
        
        let queuePlayer = AVQueuePlayer(items: items)
        let playerLayer = AVPlayerLayer(player: queuePlayer)
        view.layer.addSublayer(playerLayer)
        queuePlayer.play()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(animationDidFinish),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: queuePlayer.currentItem)
    }

    func animationDidFinish(_ notification: NSNotification) {
        print("Animation did finish")
    }

    var playerItem: AVPlayerItem {
        return AVPlayerItem(url: URL(fileURLWithPath: Bundle.main.path(forResource: currentMusic, ofType: "mp3")!))
    }

    func initPlayer() {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])
        try? AVAudioSession.sharedInstance().setActive(true)
        player.insert(playerItem, after: nil)

        let playerLayer = AVPlayerLayer(player: player)
        UIApplication.shared.keyWindow?.layer.addSublayer(playerLayer)
        //开始播放
        player.play()

        
        switch player.status {
        case .failed:
            print("failed")
        case .readyToPlay:
            print("readyToPlay")
        case .unknown:
            print("unknown")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        currentMusic = data[indexPath.section][indexPath.row]
        player.replaceCurrentItem(with: playerItem)
    }
}
