//
//  TabBarController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/26/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet weak var rootTabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
rootTabBar.barTintColor = UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1)
     
    }


}
