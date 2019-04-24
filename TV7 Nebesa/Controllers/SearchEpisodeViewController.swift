//
//  SearchEpisodeViewController.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/23/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class SearchEpisodeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var episodeTableView: UITableView!
    
    //MARK: - Properties
    private var player: AVPlayer?
    private var playerViewController = AVPlayerViewController()
    var episodeId = ""
    var searchEpisodeData: SearchEpisode = SearchEpisode() {
        didSet {
            DispatchQueue.main.async {
                self.view.reloadInputViews()
            }
        }
    }
    private var videoURLString = ""
    private var presenter: SearchEpisodePresenter?

    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    //MARK: - Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchEpisodeData.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = episodeTableView.dequeueReusableCell(withIdentifier: EpisodeCell.identifier, for: indexPath) as? EpisodeCell else {
            return UITableViewCell()
        }
        cell.cellModel = searchEpisodeData.results[indexPath.row]
        return cell
    }

    //MARK: - Private Methods
    private func setupTableView() {
        episodeTableView.delegate = self
        episodeTableView.dataSource = self
        presenter = SearchEpisodePresenter(with: self, episodeId: episodeId)
        //Register for EpisodeCell.xib
        episodeTableView.register(UINib(nibName: EpisodeCell.identifier, bundle: .none), forCellReuseIdentifier: EpisodeCell.identifier)

    }

}
