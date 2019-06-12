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
    @IBOutlet weak var RecommendCaptionLabel: UILabel!
        
    override func awakeFromNib() {
//        let captionLabelHeight = RecommendCaptionLabel.optimalHeight
//        RecommendCaptionLabel.frame = CGRect(x: RecommendCaptionLabel.frame.origin.x, y: RecommendCaptionLabel.frame.origin.y, width: RecommendCaptionLabel.frame.width, height: captionLabelHeight)
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
        if cellModel.name.isEmpty {
           RecommendTitleLabel.text = cellModel.seriesName
        } else {
           RecommendTitleLabel.text = cellModel.name
        }
        RecommendDateLabel.text = "\(dateFormatter(cellModel.firstBroadcast))"
        if cellModel.caption.isEmpty {
          RecommendCaptionLabel.text = cellModel.description
        } else {
        RecommendCaptionLabel.text = cellModel.caption
        }
        guard let previewImageURL = URL.init(string: cellModel.homeScreenVideoPreviewImageURLString) else {
            return
        }
        let cacheKey = cellModel.homeScreenVideoPreviewImageURLString
        let resource = ImageResource(downloadURL: previewImageURL, cacheKey: cacheKey)
        //        imageView.kf.setImage(with: resource)
        let cache = ImageCache.default
        let cached = cache.isCached(forKey: cacheKey)
        
        // To know where the cached image is:
        let cacheType = cache.imageCachedType(forKey: cacheKey)
        print(cacheType, cached)
        RecommendImageView.kf.setImage(with: resource)
//        RecommendImageView.kf.setImage(with: previewImageURL)
    }
    
    private func dateFormatter(_ dateIn: String) -> String {
        guard let unixDate = Double(dateIn) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate/1000.0 )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        
        let newDate = dateFormatter.string(from: date)
        return newDate
    }

//    TimeInterval(cellModel.firstBroadcast).map(Date.init(timeIntervalSince1970:)).map(dateFormatter.string)
}


