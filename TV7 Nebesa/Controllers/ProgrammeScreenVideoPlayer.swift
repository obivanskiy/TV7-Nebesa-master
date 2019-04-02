//
//  ProgrammeScreenVideoPlayer.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/1/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation
import AVFoundation
class ProgrammeScreenVideoPlayer: NSObject {
    let view = ProgrammeScreenViewController().programmeView
    
    func setView() {
        self.view?.backgroundColor = .red
    }
}
