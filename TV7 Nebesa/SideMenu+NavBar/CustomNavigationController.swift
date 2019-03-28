//
//  CustomNavigationController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/28/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

public class CustomNavigationController: UINavigationController {

    
    public override func viewDidLoad() {
    super.viewDidLoad()
    
        let bar = navigationBar
        bar.barStyle = UIBarStyle.blackOpaque
        bar.barTintColor = UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1)
        bar.isTranslucent = false
        
        
}

}
