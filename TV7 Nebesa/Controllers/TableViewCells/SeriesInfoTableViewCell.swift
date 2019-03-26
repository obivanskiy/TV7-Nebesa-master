//
//  SeriesInfoTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/19/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class SeriesInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var seriesPreviewImage: UIImageView!
    @IBOutlet weak var seriesNameLabel: UILabel!
    @IBOutlet weak var seriesDescriptionLabel: UILabel!
    
    var cellModel: SeriesInfo? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
        }
    }
    
    func setupUI(cellModel: SeriesInfo) {
        seriesNameLabel.text = cellModel.name
        seriesDescriptionLabel.text = cellModel.caption
        self.isUserInteractionEnabled = false
        
        guard let previewImageURL = URL.init(string: cellModel.imagePath) else {
            return
        }
        seriesPreviewImage.kf.setImage(with: previewImageURL)
    }

}
