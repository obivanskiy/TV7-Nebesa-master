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

let kCastControlBarsAnimationDuration: TimeInterval = 0.20

class VideoPlayer: UIViewController, GCKSessionManagerListener, GCKRemoteMediaClientListener, GCKRequestDelegate, GCKUIMiniMediaControlsViewControllerDelegate {
    
    
    @IBOutlet var castVideoButton: UIButton!
    @IBOutlet var castInstructionLabel: UILabel!
      @IBOutlet private var _miniMediaControlsContainerView: UIView!
      @IBOutlet private var _miniMediaControlsHeightConstraint: NSLayoutConstraint!
    private var castButton: GCKUICastButton!
    private var mediaInformation: GCKMediaInformation?
    private var sessionManager: GCKSessionManager!
    //MARK: - Stored properties
    private var player: AVPlayer?
    private var playerViewController = AVPlayerViewController()
    var video: Video?
    var videoData : HomeScreenProgrammeInformation = HomeScreenProgrammeInformation(){
        didSet{
            print("---------------> Video data has been recieved")
            setUpVideoData()
            setUpUI()
            DispatchQueue.main.async {
//                                self.createPlayerView()
                self.player(urlString: self.videoURLString)
                            }
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
    
   private var miniMediaControlsViewController: GCKUIMiniMediaControlsViewController!
    var miniMediaControlsViewEnabled = false {
        didSet {
            if isViewLoaded {
                updateControlBarsVisibility()
            }
        }
    }
    
     var miniMediaControlsItemEnabled = false
    //MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        _miniMediaControlsHeightConstraint.constant = 45
        let castContext = GCKCastContext.sharedInstance()
        miniMediaControlsViewController = castContext.createMiniMediaControlsViewController()
        updateControlBarsVisibility()
        installViewController(miniMediaControlsViewController,
                              inContainerView: _miniMediaControlsContainerView)
        
        if videoID != "" {
        fetchVideos()
        } else {
            setUpUI()
        }
        // Initially hide the cast button until a session is started.
        showLoadVideoButton(showButton: false)
        
        sessionManager = GCKCastContext.sharedInstance().sessionManager
        sessionManager.add(self)
        
        // Add cast button.
        castButton = GCKUICastButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        miniMediaControlsViewController.delegate = self
        // Used to overwrite the theme in AppDelegate.
        castButton.tintColor = .darkGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: castButton)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(castDeviceDidChange(notification:)),
                                               name: NSNotification.Name.gckCastStateDidChange,
                                               object: GCKCastContext.sharedInstance())
    }
    
    // MARK: - GCKUIMiniMediaControlsViewControllerDelegate
    
    func miniMediaControlsViewController(_: GCKUIMiniMediaControlsViewController,
                                         shouldAppear _: Bool) {
        updateControlBarsVisibility()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard videoID == "" else {return}
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        player.stopPlayback()
    }
    
    
    func fetchVideos(){
        SVProgressHUD.setBackgroundColor(.white)
        SVProgressHUD.setForegroundColor(UIColor.blue)
        SVProgressHUD.setDefaultMaskType(.black)
        //        SVProgressHUD.show()
        ApiService.shared.requestVideoInfo { (videoData: HomeScreenProgrammeInformation) in
            self.videoData = videoData
        }
    }
    
  
    //MARK: -Set up the UI
    private func setUpVideoData() {
        
        var titleName = videoTitle
        if titleName == "" {
            titleName = videoSeriesName
        }
     
        videoTitle = videoData.homeProgrammeInfo[0].name
        videoCaption = videoData.homeProgrammeInfo[0].caption
        videoEpisodeNumber = videoData.homeProgrammeInfo[0].episodeNumber
        videoDuration = videoData.homeProgrammeInfo[0].duration
        videoFirstBroadcast = videoData.homeProgrammeInfo[0].firstBroadcast
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
        VideoFirstBroadcastLabel.text = "Доступен с: \(broadcastDateFormatter(videoFirstBroadcast))"
//        navigationItem.rightBarButtonItem = googleCastButton
    }
    
    //MARK: - Player function
//    private func createPlayerView() {
//   playerViewController.videoGravity = .resizeAspectFill
//        player = Player(frame: ProgramVideoView.bounds)
//        player.mediaItem = MediaItem(name: videoTitle, about: VideoCaptionLabel.text, videoUrl: videoURLString.encodeUrl()!, thumbnailUrl: thumbnailUrl.encodeUrl()!)
//        player.initPlayerLayer()
//
//        ProgramVideoView.addSubview(player)
//        SVProgressHUD.dismiss()
//    }
//    MARK: - Player function
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
    private func broadcastDateFormatter(_ dateIn: String) -> String {
        guard let unixDate = Double(dateIn) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
    
    
    @objc func castDeviceDidChange(notification _: Notification) {
        if GCKCastContext.sharedInstance().castState != GCKCastState.noDevicesAvailable {
            // Display the instructions for how to use Google Cast on the first app use.
            GCKCastContext.sharedInstance().presentCastInstructionsViewControllerOnce(with: castButton)
        }
    }
    
    // MARK: Cast Actions
    
    func playVideoRemotely() {
        GCKCastContext.sharedInstance().presentDefaultExpandedMediaControls()
        
        // Define media metadata.
        let metadata = GCKMediaMetadata()
        metadata.setString(self.videoTitle ?? self.videoSeriesName!, forKey: kGCKMetadataKeyTitle)
        metadata.setString(self.videoCaption ?? "Caption",
                           forKey: kGCKMetadataKeySubtitle)
        metadata.addImage(GCKImage(url: URL(string: self.thumbnailUrl)!,
                                   width: 480,
                                   height: 360))
        
        
        let mediaInfoBuilder = GCKMediaInformationBuilder(contentURL: URL(string: self.videoURLString.encodeUrl()!)!)
        mediaInfoBuilder.streamType = GCKMediaStreamType.none
        mediaInfoBuilder.contentType = "video/mp4"
        mediaInfoBuilder.metadata = metadata
        mediaInformation = mediaInfoBuilder.build()
        
        print(self.thumbnailUrl, self.videoURLString.encodeUrl()!)
        
        let mediaLoadRequestDataBuilder = GCKMediaLoadRequestDataBuilder()
        mediaLoadRequestDataBuilder.mediaInformation = mediaInformation
        
        // Send a load request to the remote media client.
        if let request = sessionManager.currentSession?.remoteMediaClient?.loadMedia(with: mediaLoadRequestDataBuilder.build()) {
            request.delegate = self
        }
    }
    
    @IBAction func loadVideo(sender _: AnyObject) {
        print("Load Video")
        
        if sessionManager.currentSession == nil {
            print("Cast device not connected")
            return
        }
        
        playVideoRemotely()
    }
    
    func showLoadVideoButton(showButton: Bool) {
        castVideoButton.isHidden = !showButton
        // Instructions should always be the opposite visibility of the video button.
        castInstructionLabel.isHidden = !castVideoButton.isHidden
    }
    
    // MARK: GCKSessionManagerListener
    
    func sessionManager(_: GCKSessionManager,
                        didStart session: GCKSession) {
        print("sessionManager didStartSession: \(session)")
        
        // Add GCKRemoteMediaClientListener.
        session.remoteMediaClient?.add(self)
        
        showLoadVideoButton(showButton: true)
    }
    
    func sessionManager(_: GCKSessionManager,
                        didResumeSession session: GCKSession) {
        print("sessionManager didResumeSession: \(session)")
        
        // Add GCKRemoteMediaClientListener.
        session.remoteMediaClient?.add(self)
        
        showLoadVideoButton(showButton: true)
    }
    
    func sessionManager(_: GCKSessionManager,
                        didEnd session: GCKSession,
                        withError error: Error?) {
        print("sessionManager didEndSession: \(session)")
        
        // Remove GCKRemoteMediaClientListener.
        session.remoteMediaClient?.remove(self)
        
        if let error = error {
            showError(error)
        }
        
        showLoadVideoButton(showButton: false)
    }
    
    func sessionManager(_: GCKSessionManager,
                        didFailToStart session: GCKSession,
                        withError error: Error) {
        print("sessionManager didFailToStartSessionWithError: \(session) error: \(error)")
        
        // Remove GCKRemoteMediaClientListener.
        session.remoteMediaClient?.remove(self)
        
        showLoadVideoButton(showButton: false)
    }
    
    // MARK: GCKRemoteMediaClientListener
    
    func remoteMediaClient(_: GCKRemoteMediaClient,
                           didUpdate mediaStatus: GCKMediaStatus?) {
        if let mediaStatus = mediaStatus {
            mediaInformation = mediaStatus.mediaInformation
        }
    }
    
    // MARK: - GCKRequestDelegate
    
    func requestDidComplete(_ request: GCKRequest) {
        print("request \(Int(request.requestID)) completed")
    }
    
    func request(_ request: GCKRequest,
                 didFailWithError error: GCKError) {
        print("request \(Int(request.requestID)) didFailWithError \(error)")
    }
    
    func request(_ request: GCKRequest,
                 didAbortWith abortReason: GCKRequestAbortReason) {
        print("request \(Int(request.requestID)) didAbortWith reason \(abortReason)")
    }
    
    // MARK: Misc
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func updateControlBarsVisibility() {
        if miniMediaControlsViewEnabled, miniMediaControlsViewController.active {
            _miniMediaControlsHeightConstraint.constant = miniMediaControlsViewController.minHeight
            view.bringSubviewToFront(_miniMediaControlsContainerView)
        } else {
            
            _miniMediaControlsHeightConstraint.constant = 0
            
            
        }
        UIView.animate(withDuration: kCastControlBarsAnimationDuration, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        view.setNeedsLayout()
    }
    func installViewController(_ viewController: UIViewController?, inContainerView containerView: UIView) {
        if let viewController = viewController {
            addChild(viewController)
            viewController.view.frame = containerView.bounds
            containerView.addSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
    }
    func uninstallViewController(_ viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    
    
}



