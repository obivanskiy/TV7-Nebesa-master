//
//  ProgrammeScreenViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/1/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import GoogleCast

final class ProgrammeScreenViewController: UIViewController, Castable {
    
    //MARK: - Stored properties
    private var player: AVPlayer?
    private var playerViewController = AVPlayerViewController()
    static var programmeData: ProgrammesData = ProgrammesData()
    private var videoURLString: String = ""
    private var screenTitle: String = "ВИДЕО"
    
    //MARK: - Outlets
    @IBOutlet weak var programmeView: UIView!
    @IBOutlet weak var seriesNameLabel: UILabel!
    @IBOutlet weak var seriesProgrammeName: UILabel!
    @IBOutlet weak var programmeCaption: UILabel!
    @IBOutlet weak var programmeNumberLabel: UILabel!
    @IBOutlet weak var programmeLenghtLabel: UILabel!
    
    private var playerView: Player!
    
    
    //MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //player(urlString: videoURLString)
       createPlayerView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        playerView.stopPlayback()
    }

    //MARK: -Set up the UI
    private func setUpUI() {
        seriesNameLabel.text = ProgrammeScreenViewController.programmeData.seriesName
        seriesProgrammeName.text = ProgrammeScreenViewController.programmeData.name
        programmeCaption.text = ProgrammeScreenViewController.programmeData.caption
        programmeNumberLabel.text = "Эпизод: \(ProgrammeScreenViewController.programmeData.episodeNumber)"
        programmeLenghtLabel.text = "Длительность: \(dateFormatter(ProgrammeScreenViewController.programmeData.duration))"
        // set up url from the data source
        self.videoURLString = NetworkEndpoints.baseURLForVideoPlayback + ProgrammeScreenViewController.programmeData.linkPath + NetworkEndpoints.playlistEndpoint
        self.title = self.screenTitle
        navigationItem.rightBarButtonItem = googleCastButton
    }
    
    private func createPlayerView() {
        playerView = Player(frame: programmeView.bounds)
        print(videoURLString)
        playerView.mediaItem = MediaItem(name: ProgrammeScreenViewController.programmeData.seriesName, about: ProgrammeScreenViewController.programmeData.caption, videoUrl: videoURLString.encodeUrl()!, thumbnailUrl: nil)
        playerView.initPlayerLayer()
        programmeView.addSubview(playerView)
    }

    
    //MARK: - Player function
//    private func player(urlString: String) {
//        if let  videoURL = URL(string: urlString.encodeUrl()!) {
//            self.player = AVPlayer(url: videoURL)
//            playerViewController.player = self.player
//            playerViewController.view.frame = programmeView.bounds
//            self.addChild(playerViewController)
//            programmeView.addSubview(playerViewController.view)
//            playerViewController.didMove(toParent: self)
//            playerViewController.player?.pause()
//
//        }
//    }
    
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
