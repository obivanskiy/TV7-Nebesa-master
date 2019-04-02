//
//  CustomNavigationBar.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/29/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    private func setUp() {
        prefersLargeTitles = true
        barStyle = .blackOpaque
        barTintColor = UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1)
        isTranslucent = false
        frame = CGRect(x: 0, y: 0, width: frame.width , height: 200)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
