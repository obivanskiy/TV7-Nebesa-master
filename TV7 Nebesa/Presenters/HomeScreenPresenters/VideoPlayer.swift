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
import SVProgressHUD

class VideoPlayer: UIViewController, Castable {
    
    
    
    //MARK: - Stored properties
    private var player: Player!
    private var playerViewController = AVPlayerViewController()
    
    var video: Video?
    var videoData : HomeScreenProgrammeInformation = HomeScreenProgrammeInformation(){
        didSet{
            print("---------------> Video data has been recieved")
            setUpVideoData()
            setUpUI()
            DispatchQueue.main.async {
                                self.createPlayerView()
                            }
        }
    }
  
    
    func fetchVideos(){
        SVProgressHUD.setBackgroundColor(.white)
        SVProgressHUD.setForegroundColor(UIColor.blue)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        ApiService.shared.requestVideoInfo { (videoData: HomeScreenProgrammeInformation) in
            self.videoData = videoData
        }
        
        
    }
    
    

    var videoID: String = "" {
        didSet{
            print("ANY")
        }
    }
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
        if videoID != "" {
        fetchVideos()
        } else {
            setUpUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard videoID == "" else {return}
        createPlayerView()
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
        VideoEpisodeNumberLabel.text = videoEpisodeNumber
        VideoDurationLabel.text = videoDuration
        VideoFirstBroadcastLabel.text = videoFirstBroadcast
        
        
        navigationItem.rightBarButtonItem = googleCastButton
    }
    
    //MARK: - Player function
    private func createPlayerView() {
   
        player = Player(frame: ProgramVideoView.bounds)
        player.mediaItem = MediaItem(name: videoTitle, about: VideoCaptionLabel.text, videoUrl: videoURLString.encodeUrl()!, thumbnailUrl: thumbnailUrl.encodeUrl()!)
        player.initPlayerLayer()
        ProgramVideoView.addSubview(player)
        SVProgressHUD.dismiss()
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
