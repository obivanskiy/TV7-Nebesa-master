//
//  RecommendTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//
import UIKit
import Kingfisher

class RecommendTableViewCell: UITableViewCell {
    
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

    @IBOutlet weak var RecommendImageView: UIImageView!
    @IBOutlet weak var RecommendTitleLabel: UILabel!
    @IBOutlet weak var RecommendDateLabel: UILabel!
    @IBOutlet weak var RecommendCaptionLabel: UITextView!
    
    var cellModel: HomeScreenData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
            print("OK HERE")
        }
    }
    
    private func setupUI(cellModel: HomeScreenData) {
        RecommendImageView.sizeToFit()
        RecommendTitleLabel.sizeToFit()
        RecommendTitleLabel.text = cellModel.seriesName
        
        RecommendDateLabel.text = TimeInterval(cellModel.firstBroadcast).map(Date.init(timeIntervalSince1970:)).map(dateFormatter.string)
        
        RecommendCaptionLabel.text = cellModel.caption
        
        guard let previewImageURL = URL.init(string: cellModel.homeScreenVideoPreviewImageURLString) else {
            return
        }
        RecommendImageView.kf.setImage(with: previewImageURL)
    }

    
}


