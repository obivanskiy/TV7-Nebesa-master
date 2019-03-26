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
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupUI() {
        seriesTVGuide.numberOfLines = 3
        seriesTVGuide.lineBreakMode = .byWordWrapping
        seriesTVGuide.font = UIFont.systemFont(ofSize: 14.0)
    }
    
}
