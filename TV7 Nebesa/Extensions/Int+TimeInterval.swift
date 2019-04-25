//
//  Int+TimeToString.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/23/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


extension TimeInterval {
    
    fileprivate func extractedFunc() -> NSInteger {
        return NSInteger(self)
    }
    
    func toTimeString() -> NSString {
        let ti = extractedFunc()
        let seconds = ti % 60
        let minutes = ti / 60
        
        return NSString(format: "%0.1d:%0.2d", minutes, seconds)
    }
}
