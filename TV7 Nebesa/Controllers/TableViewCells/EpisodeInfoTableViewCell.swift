//
//  EpisodeInfoTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/19/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import Kingfisher

class EpisodeInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeInfoImage: UIImageView!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeLenghtLabel: UILabel!
    @IBOutlet weak var episodeDescriptionLabel: UILabel! {
        didSet {
            episodeDescriptionLabel.numberOfLines = 2
        }
    }
    
    var cellModel: ProgrammesData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
        }
    }
    
    func setupUI(cellModel: ProgrammesData) {
        episodeNameLabel.text = cellModel.name
        episodeLenghtLabel.text = "Длительность: \(dateFormatter(cellModel.duration))"
        episodeNumberLabel.text = "Эпизод: \(cellModel.episodeNumber)"
        episodeDescriptionLabel.text = cellModel.caption
        self.selectionStyle = .none
        guard let previewImageURL = URL.init(string: cellModel.imagePath) else {
            return
        }
        episodeInfoImage.kf.setImage(with: previewImageURL)
    }
    
    private func dateFormatter(_ dateIn: String) -> String {
        guard let unixDate = Double(dateIn) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
}
