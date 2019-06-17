//
//  SearchEpisodeCell.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/17/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class SearchEpisodeCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var episodePreviewImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 2
        }
    }
    @IBOutlet weak var captionLabel: UILabel! {
        didSet {
            captionLabel.numberOfLines = 5
        }
    }

    // MARK: - Properties
    var cellModel: SearchResultsData? {
        didSet {
            guard let cellModel = cellModel else { return }
            setupUI(cellModel: cellModel)
        }
    }

    //New For SeriesVC
    var seriesCellModel: ProgrammesData? {
        didSet {
            guard let seriesCellModel = seriesCellModel else { return }
            setupUISeries(seriesCellModel: seriesCellModel)
        }
    }

    // MARK: - Private Methods
    private func setupUI(cellModel: SearchResultsData) {
        let attributedText = NSMutableAttributedString(string: cellModel.seriesName, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: " \(cellModel.name)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]))
        nameLabel.attributedText = attributedText
        captionLabel.text = cellModel.caption
        guard let previewImageURL = URL.init(string: cellModel.imagePath) else { return }
        episodePreviewImage.kf.setImage(with: previewImageURL)
        selectionStyle = .none
    }

    private func setupUISeries(seriesCellModel: ProgrammesData) {
        let attributedText = NSMutableAttributedString(string: seriesCellModel.seriesName, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: " \(seriesCellModel.name)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13)]))
        nameLabel.attributedText = attributedText
        guard let duration = Int(seriesCellModel.duration) else { return }
        captionLabel.text = "Длительность: " + String(duration/1000/60) + " Мин"
        guard let previewImageURL = URL.init(string: seriesCellModel.imagePath) else { return }
        episodePreviewImage.kf.setImage(with: previewImageURL)
        selectionStyle = .none
    }
    
}
