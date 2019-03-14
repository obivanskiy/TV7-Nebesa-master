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
    
    var previewImagePath: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        categoryVideoNameOutlet.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fetchImage() {
        if let url = URL(string: previewImagePath) {
            do{
                let data = try Data(contentsOf: url)
                categoryPreviewImageOutlet.image = UIImage(data: data)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

}
