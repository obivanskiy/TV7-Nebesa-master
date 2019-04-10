//
//  CustomNavigationController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/5/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit


class CustomNavigationController: UINavigationController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    func setUp() {
        
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
        view.addSubview(statusBarMask)
        
        navigationBar.prefersLargeTitles = false
        
        navigationBar.barStyle = .blackOpaque
        navigationBar.barTintColor = UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1) //12
        navigationBar.isTranslucent = false
        //clear navbar shadow line
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
        
        //        window?.addConstraintsWithFormat(withVisualFormat: "H:|[v0]|", views: statusBarBackgroundView)
        //        window?.addConstraintsWithFormat(withVisualFormat: "V:|[v0(40)]|", views: statusBarBackgroundView)
        
        
        //        frame = CGRect(x: 0, y: 0, width: frame.width , height: 200)
    }
}
