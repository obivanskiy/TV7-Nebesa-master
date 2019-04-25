//
//  GoogleCastPlayer.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/16/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import GoogleCast

class GoogleCastPlayer {
    
    var castManager = CastManager()
    
    init(frame: CGRect) {
        listenForCastConnection()
    }
    
    private func listenForCastConnection() {
        let sessionStatusListener: (CastManager.CastSessionStatus, String) -> Void = { status, error in
            print("Status: \(status), error \(error)")
        }   
        castManager.addSessionStatusListener(listener: sessionStatusListener)
    }
    
}
