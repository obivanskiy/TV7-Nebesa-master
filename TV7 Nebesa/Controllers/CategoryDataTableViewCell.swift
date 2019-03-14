//
//  CategoryDataTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/14/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class CategoryDataTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var categoryPreviewImageOutlet: UIImageView!
    @IBOutlet weak var categoryVideoNameOutlet: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
