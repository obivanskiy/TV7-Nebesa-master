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
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//    }
//
    private func setupUI(cellModel: SearchResultsData) {
        seriesNameLabel.text = cellModel.name
        captionLabel.text = cellModel.caption
        guard let previewImageURL = URL.init(string: cellModel.imagePath) else { return }
        seriesPreviewImage.kf.setImage(with: previewImageURL)
        self.selectionStyle = .none
        
    }

}
