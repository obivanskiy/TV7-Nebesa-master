//
//  AppDelegate.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var menuIsOpen = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        window = UIWindow()
//        window?.makeKeyAndVisible()
//
//        let layout = UICollectionViewFlowLayout()
//        window?.rootViewController = CustomNavigationController(rootViewController: HomeScreenVC(collectionViewLayout: layout))
//
//
//        UINavigationBar.appearance().barTintColor = UIColor.rgb(red: 12, green: 100, blue: 194)
//        //Clear shadow underneath navBar
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//
        application.statusBarStyle = .lightContent
//
        
//        let statusBarBackgroundView = UIView()
//        statusBarBackgroundView.backgroundColor = UIColor.rgb(red: 11, green: 90, blue: 193)
////
//        window?.addSubview(statusBarBackgroundView)
//        window?.addConstraintsWithFormat(withVisualFormat: "H:|[v0]|", views: statusBarBackgroundView)
//        window?.addConstraintsWithFormat(withVisualFormat: "V:|[v0(40)]|", views: statusBarBackgroundView)
       
        //MARK: - Setup navigation bar color
//        let navigationBarAppearace = UINavigationBar.appearance()
//        
//        navigationBarAppearace.tintColor = UIColor.init(red: 0/255 , green: 136/255, blue: 200/255, alpha: 1)
//        navigationBarAppearace.barTintColor = UIColor.init(red: 0/255 , green: 136/255, blue: 200/255, alpha: 1)

        
        return true
    }
}
