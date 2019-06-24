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
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    private var appID: String = "7666F269"
    
    private var enableGoogleCastLogging: Bool = true
    fileprivate var useCastContainerViewController = false
    
    var isCastControlBarsEnabled: Bool {
        get {
            if useCastContainerViewController {
                let castContainerVC = (window?.rootViewController as? GCKUICastContainerViewController)
                return castContainerVC!.miniMediaControlsItemEnabled
            } else {
                let rootContainerVC = (window?.rootViewController as? RootContainerViewController)
                return rootContainerVC!.miniMediaControlsViewEnabled
            }
        }
        set(notificationsEnabled) {
            if useCastContainerViewController {
                var castContainerVC: GCKUICastContainerViewController?
                castContainerVC = (window?.rootViewController as? GCKUICastContainerViewController)
                castContainerVC?.miniMediaControlsItemEnabled = notificationsEnabled
            } else {
                var rootContainerVC: RootContainerViewController?
                rootContainerVC = (window?.rootViewController as? RootContainerViewController)
                rootContainerVC?.miniMediaControlsViewEnabled = notificationsEnabled
            }
        }
    }
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        UITabBar.appearance().backgroundColor = UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1) //12
        UINavigationBar.appearance().tintColor = .white
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playback)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        if useCastContainerViewController {
            let appStoryboard = UIStoryboard(name: "Main", bundle: nil)
            guard let navigationController = appStoryboard.instantiateViewController(withIdentifier: "RootTabBarController")
                as? UINavigationController else { return false }
            let castContainerVC = GCKCastContext.sharedInstance().createCastContainerController(for: navigationController)
                as GCKUICastContainerViewController
            castContainerVC.miniMediaControlsItemEnabled = false
            window = UIWindow(frame: UIScreen.main.bounds)
            window?.rootViewController = castContainerVC
            window?.makeKeyAndVisible()
        } else {
            let rootContainerVC = (window?.rootViewController as? RootContainerViewController)
            rootContainerVC?.miniMediaControlsViewEnabled = true
        }

        // Restrict size and expiration for cache
        let cache = ImageCache.default
        cache.memoryStorage.config.totalCostLimit = 300 * 1024 * 1024
        cache.diskStorage.config.sizeLimit = 1000 * 1024 * 1024
        cache.memoryStorage.config.expiration = .days(1)


        CastManager.shared.initialise()
        
        return true
    }
}

extension AppDelegate: GCKLoggerDelegate {
    func logMessage(_ logMessage: String, at: GCKLoggerLevel, fromFunction function: String, location: String) {
        if enableGoogleCastLogging{
            print("Location: \(location),  function: \(function),  - \(logMessage) ")
        }
    }
}

