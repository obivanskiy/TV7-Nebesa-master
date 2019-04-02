//
//  DateCollectionViewCell.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 3/19/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!

    var date: String {
        didSet {
            dateLabel.text = date
        }
    }

    override var isSelected: Bool {
        didSet {
            dateLabel.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.date = ""
        super.init(coder: aDecoder)
    }
}
