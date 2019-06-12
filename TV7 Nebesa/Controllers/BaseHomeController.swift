//
//  BaseHomeController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/4/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//
import Foundation
import UIKit

class BaseHomeController: UIViewController {

    private enum Constants {
        static let programmeScreen = "ProgrammeScreen"
        static let searchVC = "SearchViewController"
    }
  

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBarButtons()
        setUpStatusBar()
        

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
        view.addSubview(statusBarMask)
    }
    
    func setupNavBarButtons() {
//        _ = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let slideBottomMenuButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(slideBottomMenu))
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
//        let moreButton = UIBarButtonItem(image: UIImage(named: "tvIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [slideBottomMenuButton, searchBarButtonItem]
    }
//    @objc func handleMore() {
//
//    }
    
    @objc func slideBottomMenu() {
        print("menu")
    }
    
    @objc func handleSearch() {
        guard let searchVC = UIStoryboard(name: Constants.programmeScreen, bundle: nil).instantiateViewController(withIdentifier: Constants.searchVC) as? SearchViewController else { return }
        self.navigationController?.pushViewController(searchVC, animated: true)
        print("Search")
    }
    
}
    
   
