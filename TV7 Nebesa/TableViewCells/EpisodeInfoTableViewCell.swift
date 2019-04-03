//
//  EpisodeInfoTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/19/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class EpisodeInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeInfoImage: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeLenghtLabel: UILabel!
    @IBOutlet weak var episodeDescriptionLabel: UILabel!
//    
//    var cellModel: SeriesInfo? {
//        didSet {
//            guard let cellModel = cellModel else { return }
//            setupUI(cellModel: cellModel)
//        }
//    }
//
//    func setupUI(cellModel: SeriesInfo) {
//        seriesNameLabel.text = cellModel.name
//        seriesDescriptionLabel.text = cellModel.caption
//        guard let previewImageURL = URL.init(string: cellModel.imagePath) else {
//            return
//        }
//        seriesPreviewImage.kf.setImage(with: previewImageURL)
//    }

}