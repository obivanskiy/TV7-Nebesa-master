//
//  System.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/1/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit


struct System {
    static func clearNavigationBar(forBar navBar: UINavigationBar) {
        navBar.setBackgroundImage(UIImage(), for: .default)
        navBar.shadowImage = UIImage()
        navBar.isTranslucent = true
    }
}


//private func setUp() {
//
//    prefersLargeTitles = true
//    barStyle = .blackOpaque
//    barTintColor = UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1)
//    isTranslucent = false
//    //frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: 200)
//}


//}
