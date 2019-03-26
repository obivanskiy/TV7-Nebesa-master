//
//  CategoryDataTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/14/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import Kingfisher

final class CategoryDataTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var videoPreviewImageView: UIImageView!
    @IBOutlet weak var categoryVideoNameLabel: UILabel!
    
    var cellModel: CategoryProgrammesData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
        }
    }

    private func setupUI(cellModel: CategoryProgrammesData) {
        categoryVideoNameLabel.sizeToFit()
        categoryVideoNameLabel.text = cellModel.name
        guard let previewImageURL = URL.init(string: cellModel.videoPreviewImageURLString) else {
            return
        }
        videoPreviewImageView.kf.setImage(with: previewImageURL)
    }
}
