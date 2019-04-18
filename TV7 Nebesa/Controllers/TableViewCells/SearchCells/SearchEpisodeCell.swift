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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
