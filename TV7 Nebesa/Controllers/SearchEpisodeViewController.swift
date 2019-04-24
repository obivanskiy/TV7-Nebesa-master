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

class SearchEpisodeViewController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Episode id in SearchEpisodeVC : \(episodeId)")
        presenter = SearchEpisodePresenter(with: self, episodeId: episodeId)
    }


}
