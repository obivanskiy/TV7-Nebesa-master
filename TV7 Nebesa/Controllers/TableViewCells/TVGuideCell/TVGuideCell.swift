//
//  TVGuideCell.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 3/18/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class TVGuideCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var captionLabelHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // Expand Cell when select
    var isExpanded: Bool = false {
        didSet {
            if !isExpanded {
                self.captionLabelHeight.constant = 0.0
            } else {
                self.captionLabelHeight.constant = 100
            }
        }
    }

    private func setupUI() {
        seriesLabel.numberOfLines = 3
        seriesLabel.lineBreakMode = .byWordWrapping
        seriesLabel.font = UIFont.systemFont(ofSize: 15)
        captionLabel.numberOfLines = 0
        captionLabel.lineBreakMode = .byWordWrapping
    }
}

