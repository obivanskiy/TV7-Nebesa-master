//
//  TabBar.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/26/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class TabBar: UIView {
var barTintColor: UIColor?
    
    override func awakeFromNib() {
        self.barTintColor = .clear
        self.backgroundColor = UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1) //12
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
