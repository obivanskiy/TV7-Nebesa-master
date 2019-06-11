//
//  SearchSeriesCell.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/16/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import Kingfisher

class SearchSeriesCell: UITableViewCell {
    @IBOutlet weak var seriesPreviewImage: UIImageView!
    @IBOutlet weak var seriesNameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel! {
        didSet {
            captionLabel.numberOfLines = 5
        }
    }

    var cellModel: SearchResultsData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
        }
    }

    private func setupUI(cellModel: SearchResultsData) {
        guard let imageURL = URL(string: cellModel.imagePath) else { return }
//        let resourse = ImageResource(downloadURL: imageURL, cacheKey: "SearchSeriesCellCache")
        seriesPreviewImage.kf.indicatorType = .activity
        seriesPreviewImage.kf.setImage(with: imageURL)
        seriesNameLabel.text = cellModel.name
        captionLabel.text = cellModel.caption
        self.selectionStyle = .none
    }

}
