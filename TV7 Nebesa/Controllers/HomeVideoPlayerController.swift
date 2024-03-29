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
import GoogleCast

class HomeVideoPlayerController: UIViewController, Castable {
    
    private var presenter: VideoPresenter?
   
    //MARK: - Stored properties
    private var player: Player!
    private var playerViewController = AVPlayerViewController()
    
    static var videoData : HomeScreenProgrammeInformation = HomeScreenProgrammeInformation()
    
    static var programInfo: ProgrammeInfo = ProgrammeInfo() {
        didSet {
            
            print(programInfo)
        }
    }
    var videoID: String = ""
    private var screenTitle: String = "ВИДЕО"
    var videoTitle: String? = ""
    var videoSeriesName: String? = ""
    var videoCaption: String? = ""
    var videoEpisodeNumber: String = ""
    var videoDuration: String = ""
    var videoFirstBroadcast: String = ""
    var videoURLString: String = ""
    
   

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
//        self.presenter = VideoPresenter(with: self)
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createPlayerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.stopPlayback()
    }

    //MARK: -Set up the UI

        private func setUpUI() {
            
            var titleName = videoTitle
            if titleName == "" {
                titleName = videoSeriesName
            }
            VideoTitleLabel.text = titleName
            VideoCaptionLabel.text = videoCaption
            VideoEpisodeNumberLabel.text = "Эпизод: \(videoEpisodeNumber)"
            VideoDurationLabel.text = "Длительность: \(dateFormatter(videoDuration))"
            VideoFirstBroadcastLabel.text = "Доступен с:\(broadcastDateFormatter(videoFirstBroadcast))"
            navigationItem.rightBarButtonItem = googleCastButton
        }
    
    //MARK: - Player function
    private func createPlayerView() {
        player = Player(frame: ProgramVideoView.bounds)
        player.mediaItem = MediaItem(name: videoTitle, about: videoCaption, videoUrl: videoURLString.encodeUrl()!, thumbnailUrl: nil)
        player.initPlayerLayer()
        ProgramVideoView.addSubview(player)
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
    private func broadcastDateFormatter(_ dateIn: String) -> String {
        guard let unixDate = Double(dateIn) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
    
    
}
