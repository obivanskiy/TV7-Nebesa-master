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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        //MARK: - Setup navigation bar color
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.tintColor = UIColor.init(red: 0/255 , green: 136/255, blue: 200/255, alpha: 1)
        navigationBarAppearace.barTintColor = UIColor.init(red: 0/255 , green: 136/255, blue: 200/255, alpha: 1)
        navigationBarAppearace.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        //MARK: - change navigation item title color
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        
        //MARK: - Light content status bar
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        return true
    }
}
