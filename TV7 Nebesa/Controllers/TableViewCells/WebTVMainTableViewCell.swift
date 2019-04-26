//
//  WebTVMainTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/2/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class WebTVMainTableViewCell: UITableViewCell {
    @IBOutlet weak var programmeTimeLabel: UILabel!
    @IBOutlet weak var programmeNameLabel: UILabel!
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = false
        programmeNameLabel.sizeToFit()
    }
}

