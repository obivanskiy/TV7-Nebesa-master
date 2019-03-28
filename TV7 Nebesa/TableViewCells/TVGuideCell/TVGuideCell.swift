//
//  TVGuideCell.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 3/18/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class TVGuideCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var timeTVGuide: UILabel!
    @IBOutlet weak var seriesTVGuide: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var captionHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }

    var isExpanded: Bool = false {
        didSet {
            if !isExpanded {
                self.captionHeight.constant = 0.0
            } else {
                self.captionHeight.constant = 20
            }
        }
    }

    func setupUI() {
        seriesTVGuide.numberOfLines = 3
        seriesTVGuide.lineBreakMode = .byWordWrapping
        seriesTVGuide.font = UIFont.systemFont(ofSize: 15.0)
        captionLabel.numberOfLines = 3
        captionLabel.lineBreakMode = .byWordWrapping
    }
    
}
