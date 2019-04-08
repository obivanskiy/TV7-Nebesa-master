//
//  HomeVideoPlayerController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/8/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

final class HomeVideoPlayerController: UIViewController {
    
    
    //MARK: - Stored properties
    private var player: AVPlayer?
    private var playerViewController = AVPlayerViewController()
    static var programInfo: HomeScreenData = HomeScreenData()
    private var videoURLString: String = ""
    private var screenTitle: String = "ВИДЕО"

    //MARK: - Outlets
    @IBOutlet weak var ProgramVideoView: UIView!
    @IBOutlet weak var VideoTitleLabel: UILabel!
    @IBOutlet weak var VideoCaptionLabel: UILabel!
    @IBOutlet weak var VideoEpisodeNumberLabel: UILabel!
    @IBOutlet weak var VideoDurationLabel: UILabel!
    @IBOutlet weak var VideoFirstBroadcastLabel: UILabel!

    //MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        player(urlString: videoURLString)
    }
    
    //MARK: -Set up the UI
    private func setUpUI() {
        
        VideoTitleLabel.text = HomeVideoPlayerController.programInfo.name
        VideoCaptionLabel.text = HomeVideoPlayerController.programInfo.caption
        VideoEpisodeNumberLabel.text = "Эпизод: \(HomeVideoPlayerController.programInfo.episodeNumber)"
        VideoDurationLabel.text = "Длительность: \(dateFormatter(HomeVideoPlayerController.programInfo.duration))"
        
        
        // set up url from the data source
        self.videoURLString = NetworkEndpoints.baseURLForVideoPlayback + HomeVideoPlayerController.programInfo.linkPath + NetworkEndpoints.playlistEndpoint
        print(videoURLString)
        self.title = self.screenTitle
    }
    
    //MARK: - Player function
    private func player(urlString: String) {
        if let  videoURL = URL(string: urlString.encodeUrl()!) {
            self.player = AVPlayer(url: videoURL)
            playerViewController.player = self.player
            playerViewController.view.frame = ProgramVideoView.bounds
            self.addChild(playerViewController)
            ProgramVideoView.addSubview(playerViewController.view)
            playerViewController.didMove(toParent: self)
            playerViewController.player?.pause()
        }
    }
    
    //MARK: - Date formatter
    private func dateFormatter(_ dateIn: String) -> String {
        guard let unixDate = Double(dateIn) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
    
    
}