//
//  WebTVDateTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/2/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class WebTVDateTableViewCell: UITableViewCell {
    @IBOutlet weak var todayDateLabel: UILabel!
    
    private var currentDateAndTime: String =  ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }
    
    private func setUpCell() {
        self.layer.borderWidth = 0.5
        self.backgroundColor = .lightGray
        self.layer.borderColor = UIColor.darkGray.cgColor
        getCurrentTimeAndDate()
        todayDateLabel.text = currentDateAndTime
    }

    private func getCurrentTimeAndDate() {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy  HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        currentDateAndTime = dateString
    }
}

struct DateTimeFormatter {
    
    enum DateTimeFormat: String {
        case fullDateTime = "dd.MM.yyyy  HH:mm:ss"
    }
    
    static func getStringWithFormat(format: DateTimeFormat) -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        let date = Date()
        return dateFormatter.string(from: date)
    }
}
