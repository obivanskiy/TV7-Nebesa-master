//
//  Castable+Extension.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/16/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation
import UIKit
import GoogleCast

protocol Castable {
    var googleCastButton: UIBarButtonItem! {get}
}

extension Castable {
    var googleCastButton: UIBarButtonItem! {
        let castButton = GCKUICastButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        castButton.tintColor = UIColor.white
        return UIBarButtonItem(customView: castButton)
    }
}
