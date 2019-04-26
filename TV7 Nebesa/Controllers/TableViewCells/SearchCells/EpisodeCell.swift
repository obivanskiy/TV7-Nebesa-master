//
//  EpisodeCell.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/24/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class EpisodeCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var episodeVideoView: UIView!
    @IBOutlet weak var seriesNameLabel: UILabel! {
        didSet {
            seriesNameLabel.numberOfLines = 2
        }
    }
    @IBOutlet weak var captionLabel: UILabel! {
        didSet {
            captionLabel.numberOfLines = 5
        }
    }
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var firstBroadcast: UILabel!

    //MARK: - Properties
    private var videoURL = ""
    private var player: AVPlayer?
    var playerViewController = AVPlayerViewController()

    var cellModel: SearchEpisodeData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
        }
    }

    private func setupUI(cellModel: SearchEpisodeData) {
        let attributedText = NSMutableAttributedString(string: cellModel.sname, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        attributedText.append(NSAttributedString(string: " \(cellModel.name)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]))
        seriesNameLabel.attributedText = attributedText
        captionLabel.text = cellModel.caption
        episodeNumberLabel.text = "Эпизод: " + cellModel.episodeNumber
        let duration = Int(cellModel.duration)
        guard let durationInMinutes = duration else { return }
        durationLabel.text = "Длительность: " + String(durationInMinutes/1000/60) + " Мин"
        firstBroadcast.text = "Первая трансляция: " + dateFormatter(cellModel.visibleOnVodSince)
        videoURL = NetworkEndpoints.baseURLForVideoPlayback + cellModel.path + NetworkEndpoints.playlistEndpoint
        setupPlayer(from: videoURL)
        print(videoURL)
    }

    private func dateFormatter(_ date: String) -> String {
        guard let unixDate = Double(date) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let newDate = dateFormatter.string(from: date)
        return newDate
    }

    private func setupPlayer(from urlString: String) {
        if let videoURL = URL(string: urlString.encodeUrl()!) {
            player = AVPlayer(url: videoURL)
            playerViewController.player = player
            playerViewController.view.frame = episodeVideoView.bounds
            episodeVideoView.addSubview(playerViewController.view)
            playerViewController.player?.pause()
        }
    }

    func stopPlayback() {
        playerViewController.player?.pause()
    }
}
