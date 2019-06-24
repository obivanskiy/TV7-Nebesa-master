//
//  MiniMediaControllsView.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 6/24/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class MiniMediaControllsView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let height: CGFloat = 49
        let frame = CGRect(x: 0, y: UIScreen.main.bounds.height - height, width: UIScreen.main.bounds.width, height: height)
        let miniMedia = UIView(frame: frame)
    }
   
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
