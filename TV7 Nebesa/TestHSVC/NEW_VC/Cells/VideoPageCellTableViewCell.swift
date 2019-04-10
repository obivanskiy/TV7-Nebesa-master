//
//  VideoPageCellTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/5/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class VideoPageCellTableViewCell: UITableViewCell {

   
    @IBOutlet weak var VideoPreviewImage: UIImageView!
    @IBOutlet weak var VideoTitleLabel: UILabel!
    @IBOutlet weak var VideoDescriptionLabel: UILabel!
    @IBOutlet weak var VideoEpisodeNumberLabel: UILabel!
    @IBOutlet weak var VideoDurationLabel: UILabel!
    @IBOutlet weak var VideoFirstBroadcastLabel: UILabel!
    
    
    var cellModel: HomeScreenData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
        }
    }
    
    func setupUI(cellModel: HomeScreenData) {
        VideoTitleLabel.text = cellModel.name
        VideoDescriptionLabel.text = cellModel.caption
        VideoEpisodeNumberLabel.text = cellModel.caption
        VideoDurationLabel.text = cellModel.caption
        VideoFirstBroadcastLabel.text = cellModel.caption
        
        self.isUserInteractionEnabled = false
        
        guard let previewImageURL = URL.init(string: cellModel.homeScreenVideoPreviewImageURLString) else {
            return
        }
        VideoPreviewImage.kf.setImage(with: previewImageURL)
    }
}
