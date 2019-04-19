//
//  SearchEpisodeCell.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/17/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class SearchEpisodeCell: UITableViewCell {
    @IBOutlet weak var episodePreviewImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 2
        }
    }
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    private func setupUI(cellModel: SearchResultsData) {
        let attributedText = NSMutableAttributedString(string: cellModel.seriesName, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: " \(cellModel.name)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]))
        nameLabel.attributedText = attributedText
        captionLabel.text = cellModel.caption
        guard let previewImageURL = URL.init(string: cellModel.imagePath) else { return }
        episodePreviewImage.kf.setImage(with: previewImageURL)
        self.selectionStyle = .none
    }
    
}
