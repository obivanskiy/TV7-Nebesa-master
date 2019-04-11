//
//  NebesaPlayer.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/11/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import AVKit


class NebesaPlayer {
    let url: String
    let view: UIView
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!
    
    
    init(url: String, for view: UIView) {
        self.url = url
        self.view = view
        createPlayer()
    }
    
    func createPlayer() {
        if let videoURL = URL(string: url.encodeUrl() ?? "") {
            self.player = AVPlayer(url: videoURL)
            playerViewController.player = player
            playerViewController.view.frame = view.bounds
            view.addSubview(playerViewController.view)
            playerViewController.player?.pause()
        }
    }
    
    func playerStopPlayback() {
        playerViewController.player?.pause()
    }
}
