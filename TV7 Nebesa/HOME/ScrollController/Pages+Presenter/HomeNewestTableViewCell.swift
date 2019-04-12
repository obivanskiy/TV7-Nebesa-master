//
//  Hoem NewestTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import Kingfisher

class HomeNewestTableViewCell: UITableViewCell {
    
        private let dateFormatter = DateFormatter()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setUp()
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setUp()
        }
        
        func setUp() {
            dateFormatter.dateFormat = "MM-dd-YYYY HH:mm"
        }

    @IBOutlet weak var NewestImageView: UIImageView!
    @IBOutlet weak var NewestTitleLabel: UILabel!
    @IBOutlet weak var NewestDateLabel: UILabel!
    @IBOutlet weak var NewestCaptionLabel: UITextView!
    

    var cellModel: HomeScreenData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
            print("OK HERE")
        }
    }
    
    private func setupUI(cellModel: HomeScreenData) {
        NewestImageView.sizeToFit()
        NewestTitleLabel.sizeToFit()
        NewestTitleLabel.text = cellModel.seriesName
        
        NewestDateLabel.text = TimeInterval(cellModel.firstBroadcast).map(Date.init(timeIntervalSince1970:)).map(dateFormatter.string)
        
        NewestCaptionLabel.text = cellModel.caption
        
        guard let previewImageURL = URL.init(string: cellModel.homeScreenVideoPreviewImageURLString) else {
            return
        }
        NewestImageView.kf.setImage(with: previewImageURL)
    }
    
    
}

