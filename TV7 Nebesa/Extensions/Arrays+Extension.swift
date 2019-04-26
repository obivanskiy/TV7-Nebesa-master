//
//  Arrays+Extension.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/29/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


extension Array {
    subscript(safe index: Index) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
}
