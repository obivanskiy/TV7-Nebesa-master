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


    @IBOutlet weak var RecommendImageView: UIImageView!
    @IBOutlet weak var RecommendTitleLabel: UILabel!
    @IBOutlet weak var RecommendDateLabel: UILabel!
    @IBOutlet weak var RecommendCaptionLabel: UILabel! {
        didSet {
            RecommendCaptionLabel.numberOfLines = 3
        }
    }
    
    var cellModel: HomeScreenData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
            print("OK HERE")
        }
    }
    
    func setupUI(cellModel: HomeScreenData) {
        RecommendImageView.sizeToFit()
        RecommendTitleLabel.sizeToFit()
        RecommendTitleLabel.text = cellModel.seriesName
        
        RecommendDateLabel.text = "Длительность: \(dateFormatter(cellModel.visibleOnVodSince))"
        
        RecommendCaptionLabel.text = cellModel.caption
        
        guard let previewImageURL = URL.init(string: cellModel.homeScreenVideoPreviewImageURLString) else {
            return
        }
        RecommendImageView.kf.setImage(with: previewImageURL)
    }
    
    private func dateFormatter(_ dateIn: String) -> String {
        guard let unixDate = Double(dateIn) else { return "" }
        let date = Date(timeIntervalSinceNow: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM YYYY"
        
        let newDate = dateFormatter.string(from: date)
        return newDate
    }

//    TimeInterval(cellModel.firstBroadcast).map(Date.init(timeIntervalSince1970:)).map(dateFormatter.string)
}

