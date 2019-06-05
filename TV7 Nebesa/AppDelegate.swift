//
//  AppDelegate.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import GoogleCast
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    private var appID: String = "7666F269"
    
    private var enableGoogleCastLogging: Bool = true
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().backgroundColor = UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1) //12
        UINavigationBar.appearance().tintColor = .white
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        CastManager.shared.initialise()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if let rootViewController = self.topViewControllerWithRootViewController(rootViewController: window?.rootViewController) {
            if (rootViewController.responds(to: Selector(("canRotate")))) {
                // Unlock landscape view orientations for this view controller
                return .allButUpsideDown;
            }
        }
        
        // Only allow portrait (standard behaviour)
        return .portrait;
    }
    
    private func topViewControllerWithRootViewController(rootViewController: UIViewController!) -> UIViewController? {
        if (rootViewController == nil) { return nil }
        if (rootViewController.isKind(of: UITabBarController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UITabBarController).selectedViewController)
        } else if (rootViewController.isKind(of: UINavigationController.self)) {
            return topViewControllerWithRootViewController(rootViewController: (rootViewController as! UINavigationController).visibleViewController)
        } else if (rootViewController.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootViewController: rootViewController.presentedViewController)
        }
        return rootViewController
    }
}

extension AppDelegate: GCKLoggerDelegate {
    func logMessage(_ logMessage: String, at: GCKLoggerLevel, fromFunction function: String, location: String) {
        if enableGoogleCastLogging{
            print("Location: \(location),  function: \(function),  - \(logMessage) ")
        }
    }
}

