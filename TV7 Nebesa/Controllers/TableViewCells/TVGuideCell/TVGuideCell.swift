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

    var cellModel: TVGuideDatesData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
        }
    }

    private func setupUI(cellModel: TVGuideDatesData) {
        seriesLabel.numberOfLines = 3
        seriesLabel.lineBreakMode = .byWordWrapping
        seriesLabel.font = UIFont.systemFont(ofSize: 15)
        captionLabel.numberOfLines = 0
        captionLabel.lineBreakMode = .byWordWrapping
        switch cellModel {
        case let (x) where x.series == "":
            seriesLabel.text = cellModel.name
        case let (x) where x.name != "":
            seriesLabel.text = "\(cellModel.series): " + "\(cellModel.name)"
        default:
            seriesLabel.text = cellModel.series
        }
        timeLabel.text = dateFormatter(cellModel.date)
        captionLabel.text = cellModel.caption
    }

    private func dateFormatter(_ date: String) -> String {
        guard let unixDate = Double(date) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
}

