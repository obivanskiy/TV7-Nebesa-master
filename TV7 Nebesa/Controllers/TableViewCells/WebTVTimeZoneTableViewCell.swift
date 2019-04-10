//
//  WebTVTimeZoneTableViewCell.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/2/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class WebTVTimeZoneTableViewCell: UITableViewCell {

    @IBOutlet weak var userTimeZoneLabel: UILabel!
    var currentTimeZone: String =  ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        getCurrentTimeZone()
        print(currentTimeZone)
       setupCell()
    }
    
    private func setupCell() {
        self.layer.borderWidth = 0.5
        self.backgroundColor = .lightGray
        self.layer.borderColor = UIColor.darkGray.cgColor
        
        userTimeZoneLabel.text = currentTimeZone
        print("Priint \(currentTimeZone)")
    }
    
    private func getCurrentTimeZone() {
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        self.currentTimeZone = "\(String(TimeZone.current.identifier)): \(localTimeZoneAbbreviation)"
    }
}
