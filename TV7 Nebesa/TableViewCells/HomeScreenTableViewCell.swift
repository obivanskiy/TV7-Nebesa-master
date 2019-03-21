//
//  HomeScreenTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/20/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import Kingfisher

final class HomeScreenTableViewCell: UITableViewCell {

   
    @IBOutlet weak var HomeScreenPreviewImage: UIImageView!
    @IBOutlet weak var HomeScreenTitleLabel: UILabel!
    @IBOutlet weak var HomeScreenDateLabel: UILabel!
    @IBOutlet weak var HomeScreenDescriptionLabel: UILabel!
    
    var cellModel: HomeScreenData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
            print("OK HERE")
        }
    }
    
    private func setupUI(cellModel: HomeScreenData) {
//        HomeScreenTitleLabel.sizeToFit()
        HomeScreenTitleLabel.text = cellModel.name
        HomeScreenDateLabel.text = cellModel.visibleOnVodSince
        HomeScreenDescriptionLabel.text = cellModel.description
        
        guard let previewImageURL = URL.init(string: cellModel.homeScreenVideoPreviewImageURLString) else {
            return
        }
        HomeScreenPreviewImage.kf.setImage(with: previewImageURL)
    }
}
    
    
    
    
    
    
    
    
    
    
    
    
    

