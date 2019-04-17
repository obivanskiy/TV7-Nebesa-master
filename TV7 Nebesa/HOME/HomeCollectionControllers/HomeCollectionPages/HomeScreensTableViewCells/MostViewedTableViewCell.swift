//
//  MostViewedCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/17/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import Kingfisher

class MostViewedTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var mostViewedTitle: UILabel!
    @IBOutlet weak var mostViewedDateLabel: UILabel!
    @IBOutlet weak var mostViewedCaption: UILabel!
    @IBOutlet weak var mostViewedImageView: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    var cellModel: HomeMostViewedData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
            print("OK HERE3")
        }
    }
    
    func setupUI(cellModel: HomeMostViewedData) {
       mostViewedImageView.sizeToFit()
        mostViewedTitle.sizeToFit()
        mostViewedTitle.text = cellModel.seriesName
        
        mostViewedDateLabel.text = "Длительность: \(cellModel.time)"
        
        mostViewedCaption.text = cellModel.caption
        
        guard let previewImageURL = URL.init(string: cellModel.homeScreenMostViewedPreviewImageURLString) else {
            return
        }
        mostViewedImageView.kf.setImage(with: previewImageURL)
    }

    
    
    
    
    
}
