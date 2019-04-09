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
        setUpStatusBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
        setUpStatusBar()
    }

     func setUp() {
        
        prefersLargeTitles = false
        
        barStyle = .blackOpaque
        barTintColor = UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1) //12
        isTranslucent = false
        //clear navbar shadow line 
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
        
        
        
//        window?.addConstraintsWithFormat(withVisualFormat: "H:|[v0]|", views: statusBarBackgroundView)
//        window?.addConstraintsWithFormat(withVisualFormat: "V:|[v0(40)]|", views: statusBarBackgroundView)
        
        
//        frame = CGRect(x: 0, y: 0, width: frame.width , height: 200)
    }
    func setUpStatusBar() {
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let statusBarMaskFrame = CGRect(
            origin: CGPoint(
                x: statusBarFrame.origin.x,
                y: -statusBarFrame.size.height
            ),
            size: statusBarFrame.size
        )
        let statusBarMask = UIView(frame: statusBarMaskFrame)
        statusBarMask.autoresizingMask = .flexibleWidth
        statusBarMask.backgroundColor =  UIColor.rgb(red: 11, green: 90, blue: 193)
        addSubview(statusBarMask)
    }
  
    
    
    

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
