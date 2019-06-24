//
//  TabBarController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/26/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    @IBOutlet var miniMediaControlls: UIView!
    var heightConstraint: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       miniMediaControlls.frame.size.width = self.view.frame.width
      
        if let tempTabBar = self.tabBarController {
            let height: CGFloat = 49
            let frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 2*height, width: UIScreen.main.bounds.width, height: height)
            let miniMedia = UIView(frame: frame)
            tempTabBar.view.addSubview(miniMedia)
        }
        
//        miniMediaControlls.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = NSLayoutConstraint(item: miniMediaControlls, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
       
//        miniMediaControlls.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//        heightConstraint?.isActive = true
        NSLayoutConstraint.activate([heightConstraint!])
        

     
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
