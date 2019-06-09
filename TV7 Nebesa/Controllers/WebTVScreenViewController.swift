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
GCKRemoteMediaClientListener, GCKRequestDelegate, Castable {
    //MARK: - Outlets
    @IBOutlet weak var webTVStreamView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateAndTimeZone: UILabel!
    
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
    private var currentTimeZone: String!
    
    private(set) var sortedDates: [TVGuideDatesData] = [] {
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
        getCurrentTimeZone()
        self.dateAndTimeZone.text = getCurrentTimeAndDate() + " " + currentTimeZone
        
        //MARK: -Add to extension or func
        navigationItem.rightBarButtonItem = googleCastButton
        filterDates(programmes: webTVProgrammesList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        createPlayerView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playerView.stopPlayback()
    }
    
    override func viewWillLayoutSubviews() {
        playerView.playerViewController.view.frame = webTVStreamView.bounds
    }
    
    //MARK: - Fetch current date and time zone
    
    private func getCurrentTimeAndDate() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy  HH:mm"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        let currentDateAndTime = dateString
        
        return currentDateAndTime
    }
    
    private func getCurrentTimeZone() {
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        self.currentTimeZone = "\(String(TimeZone.current.identifier)): \(localTimeZoneAbbreviation)"
    }
    
    private func createPlayerView() {
        playerView = Player(frame: webTVStreamView.bounds)
        
        playerView.mediaItem = MediaItem(name: "Nebesa TV7 Live", about: nil, videoUrl: ruStreamLink.encodeUrl()!, thumbnailUrl: nil)
        playerView.initPlayerLayer()
        webTVStreamView.addSubview(playerView)
    }
    
    private func stopPlayback() {
        webTVPlayerViewController.player?.pause()
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WebTVMainTableViewCell", for: indexPath) as? WebTVMainTableViewCell else {
            return UITableViewCell()
        }
//        tableView.estimatedRowHeight = 120
        
        // if name in request comes as empty string, use caption instead of it
        if sortedDates[indexPath.row].name == "" {
            cell.nameLabel.text = sortedDates[indexPath.row].series
        } else if sortedDates[indexPath.row].name != "" && sortedDates[indexPath.row].name != "" {
            cell.nameLabel.text = sortedDates[indexPath.row].series + ": " + sortedDates[indexPath.row].name
        } else {
            cell.nameLabel.text = sortedDates[indexPath.row].name
        }
        cell.dateLabel.text = dateFormatter(sortedDates[indexPath.row].date)
        
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
    
    //MARK: - sort tv guide time
    private func filterDates(programmes: TVGuideDates) {
        let currentDate = String(Date().timeIntervalSince1970)
        self.sortedDates = webTVProgrammesList.tvGuideDates.filter {
            return $0.date >= currentDate
        }
    }
}
