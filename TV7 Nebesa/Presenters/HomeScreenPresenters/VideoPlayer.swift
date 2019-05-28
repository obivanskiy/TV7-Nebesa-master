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

class VideoPlayer: UIViewController, Castable {
    
    
    
    //MARK: - Stored properties
    private var player: Player!
    private var playerViewController = AVPlayerViewController()
    
    private var playerPresenter: VideoPresenter?
    var videoData : HomeScreenProgrammeInformation = HomeScreenProgrammeInformation(){
        didSet {
            

            setUpVideoData()
            
            DispatchQueue.main.async {
                self.createPlayerView()
            }
            
            print("---------------> Video data has been recieved")

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
    var thumbnailUrl: String = ""
    
    
    
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
        self.playerPresenter = VideoPresenter(with: self)
        
//        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        setUpUI()
//        createPlayerView()
        DispatchQueue.main.async {
            self.setUpUI()
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.stopPlayback()
    }
    
    //MARK: -Set up the UI
    private func setUpVideoData() {
        
        var titleName = videoTitle
        if titleName == "" {
            titleName = videoSeriesName
        }
        videoTitle = videoData.homeProgrammeInfo[0].name
        videoCaption = videoData.homeProgrammeInfo[0].caption
        videoEpisodeNumber = "Эпизод: \(videoData.homeProgrammeInfo[0].episodeNumber)"
        videoDuration = "Длительность: \(dateFormatter(videoData.homeProgrammeInfo[0].duration))"
        videoFirstBroadcast = "Доступен с:\(broadcastDateFormatter(videoData.homeProgrammeInfo[0].firstBroadcast))"
        videoURLString = NetworkEndpoints.baseURLForVideoPlayback + videoData.homeProgrammeInfo[0].path + NetworkEndpoints.playlistEndpoint
        thumbnailUrl = videoData.homeProgrammeInfo[0].imagePath
        
         print(thumbnailUrl, "----------", videoURLString)
        
        
        
//        navigationItem.rightBarButtonItem = googleCastButton
    }
    
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
        player.mediaItem = MediaItem(name: videoTitle, about: VideoCaptionLabel.text, videoUrl: videoURLString.encodeUrl()!, thumbnailUrl: thumbnailUrl)
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
