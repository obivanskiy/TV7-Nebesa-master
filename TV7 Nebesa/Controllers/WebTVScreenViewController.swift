//
//  WebTVScreenViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/2/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import AVFoundation
import  AVKit
import GoogleCast

enum PlaybackMode: Int {
    case none = 0
    case local
    case remote
}

private var playbackMode = PlaybackMode.none

class WebTVScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, GCKSessionManagerListener,
GCKRemoteMediaClientListener, GCKRequestDelegate {
    //MARK: - Outlets
    @IBOutlet weak var webTVStreamView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - GoogleCast properties
    private var castButton: GCKUICastButton!
    private var sessionManager: GCKSessionManager!
    
    //MARK: - player properties
    private var webTVPLayer: AVPlayer!
    private var webTVPlayerViewController = AVPlayerViewController()
    
    private var presenter: TVGuidePresenter?
    private var ruStreamLink: String = NetworkEndpoints.webTVVideoStreamBaseURL + NetworkEndpoints.webTVStreamRUEndpoint
    
    private var playerView: Player!
    
    var webTVProgrammesList: TVGuideDates = TVGuideDates() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sessionManager = GCKCastContext.sharedInstance().sessionManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "ВЕБ-ТВ"
        self.presenter = TVGuidePresenter(with: self)
//        player(urlString: ruStreamLink)
        
        //MARK: -Add to extension or func
        castButton = GCKUICastButton(frame: CGRect(x: CGFloat(0), y: CGFloat(0),
                                                   width: CGFloat(24), height: CGFloat(24)))
        castButton.tintColor = UIColor.blue
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: castButton)
        createPlayerView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        playerView.stopPlayback()
    }
 
    private func createPlayerView() {
        playerView = Player(frame: webTVStreamView.bounds)
        
        playerView.mediaItem = MediaItem(name: ProgrammeScreenViewController.programmeData.seriesName, about: ProgrammeScreenViewController.programmeData.caption, videoUrl: ruStreamLink.encodeUrl()!, thumbnailUrl: nil)
        playerView.initPlayerLayer()
        webTVStreamView.addSubview(playerView)
    }

    
//    private func player(urlString: String) {
//        if let  videoURL = URL(string: urlString.encodeUrl()!) {
//            self.webTVPLayer = AVPlayer(url: videoURL)
//            print("Live stream url: \(videoURL)")
//            webTVPlayerViewController.player = self.webTVPLayer
//            webTVPlayerViewController.view.frame = webTVStreamView.bounds
//            self.addChild(webTVPlayerViewController)
//            webTVStreamView.addSubview(webTVPlayerViewController.view)
//            webTVPlayerViewController.didMove(toParent: self)
//            webTVPlayerViewController.player?.pause()
//        }
//    }
    
    private func stopPlayback() {
        webTVPlayerViewController.player?.pause()
    }

    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webTVProgrammesList.tvGuideDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if  indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WebTVDateTableViewCell.identifier, for: indexPath) as? WebTVDateTableViewCell else {
                return UITableViewCell()
            }
            tableView.estimatedRowHeight = 20
            return cell
        }
        
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WebTVTimeZoneTableViewCell.identifier, for: indexPath) as? WebTVTimeZoneTableViewCell else {
                return UITableViewCell()
            }
            tableView.estimatedRowHeight = 20
            return cell
        }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WebTVMainTableViewCell.identifier, for: indexPath) as? WebTVMainTableViewCell else {
                return UITableViewCell()
            }
            tableView.estimatedRowHeight = 70
            cell.programmeNameLabel.text = webTVProgrammesList.tvGuideDates[indexPath.row].name
            cell.programmeTimeLabel.text = dateFormatter(webTVProgrammesList.tvGuideDates[indexPath.row].date)
            return cell
    }
    
    private func dateFormatter(_ dateIn: String) -> String {
        guard let unixDate = Double(dateIn) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
}
