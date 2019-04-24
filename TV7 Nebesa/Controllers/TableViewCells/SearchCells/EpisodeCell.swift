//
//  EpisodeCell.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/24/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {

    @IBOutlet weak var episodeVideoView: UIView!
    @IBOutlet weak var seriesNameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel! {
        didSet {
            captionLabel.numberOfLines = 5
        }
    }
    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var firstBroadcast: UILabel!

    var cellModel: SearchEpisodeData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
        }
    }

    private func setupUI(cellModel: SearchEpisodeData) {
        seriesNameLabel.text = cellModel.sname
        captionLabel.text = cellModel.caption
        episodeNumberLabel.text = "Эпизод: " + cellModel.episodeNumber
        let duration = Int(cellModel.duration)
        guard let durationInMinutes = duration else { return }
        durationLabel.text = "Длительность: " + String(durationInMinutes/1000/60) + " Мин"
        firstBroadcast.text = "Первая трансляция: " + dateFormatter(cellModel.visibleOnVodSince)
    }

    private func dateFormatter(_ date: String) -> String {
        guard let unixDate = Double(date) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate/1000)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
}
