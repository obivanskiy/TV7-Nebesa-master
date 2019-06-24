//
//  SearchEpisodeViewController.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/23/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import GoogleCast
import Kingfisher
import SVProgressHUD

final class SearchEpisodeViewController: UIViewController, Castable {

    // MARK: - Outlets
    @IBOutlet weak var episodeTableView: UITableView!
    @IBOutlet weak var episodeVideoView: UIView!

    // MARK: - Properties
    var episodeId = ""
    var searchEpisodeData: SearchEpisode = SearchEpisode() {
        didSet {
            DispatchQueue.main.async {
                self.episodeTableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }
    var episodeData: SearchEpisodeData = SearchEpisodeData()
    private var videoURLString = ""
    private var presenter: SearchEpisodePresenter?
    private var screenTitle = "ВИДЕО"
    private var playerView: Player!

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        createPlayerView()
    }

    override func viewWillLayoutSubviews() {
        playerView.playerViewController.view.frame = episodeVideoView.bounds
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait {
            print("Portrait")
            playerView.stopPlayback()
        } else if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            DispatchQueue.main.async {
                self.playerView.play()
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playerView.stopPlayback()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        playerView.removeFromSuperview()
    }

    // MARK: - Private Methods
    private func setupTableView() {
        episodeTableView.dataSource = self
        episodeTableView.tableFooterView = UIView()
        presenter = SearchEpisodePresenter(with: self, episodeId: episodeId)
        //Register for EpisodeCell.xib
        episodeTableView.register(UINib(nibName: EpisodeCell.identifier, bundle: .none), forCellReuseIdentifier: EpisodeCell.identifier)
        self.title = screenTitle
    }

    private func createPlayerView() {
        navigationItem.rightBarButtonItem = googleCastButton
        playerView = Player(frame: episodeVideoView.bounds)
        playerView.mediaItem = MediaItem(name: "\(self.episodeData.name): \(self.episodeData.caption)", about: self.episodeData.description, videoUrl: videoURLString.encodeUrl(), thumbnailUrl: self.episodeData.imagePath)
        playerView.initPlayerLayer()
        episodeVideoView.addSubview(playerView)
    }
}

// MARK: - Table View Data Source Methods
extension SearchEpisodeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchEpisodeData.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = episodeTableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier, for: indexPath) as? EpisodeCell else {
            return UITableViewCell()
        }
        cell.cellModel = searchEpisodeData.results[indexPath.row]
        guard let path = cell.cellModel?.path else { return UITableViewCell() }
        videoURLString = NetworkEndpoints.baseURLForVideoPlayback + path + NetworkEndpoints.playlistEndpoint
        createPlayerView()
        return cell
    }
}
