//
//  NewestTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/17/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import Kingfisher

class NewestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newestTitleLabel: UILabel!
    @IBOutlet weak var newestDateLabel: UILabel!
    @IBOutlet weak var newestCaptionLabel: UILabel!
    @IBOutlet weak var newestImageView: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var cellModel: HomeNewestData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
            print("OK HERE2")
        }
    }
    
    func setupUI(cellModel: HomeNewestData) {
        newestImageView.sizeToFit()
        newestTitleLabel.sizeToFit()
        
        
        if cellModel.name!.isEmpty {
            newestTitleLabel.text = cellModel.seriesName
        } else {
            newestTitleLabel.text = cellModel.name
        }
        newestDateLabel.text = "\(dateFormatter(cellModel.firstBroadcast))"
       newestCaptionLabel.text = cellModel.caption
        
        guard let previewImageURL = URL.init(string: cellModel.homeScreenNewestPreviewImageURLString) else {
            return
        }
        newestImageView.kf.setImage(with: previewImageURL)
    }
    private func dateFormatter(_ dateIn: String) -> String {
        guard let unixDate = Double(dateIn) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate/1000.0 )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        
        let newDate = dateFormatter.string(from: date)
        return newDate
    }

}
