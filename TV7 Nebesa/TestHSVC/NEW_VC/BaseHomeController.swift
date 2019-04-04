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

    
    let navigationBar = CustomNavigationBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarButtons()

    }
   
    
        
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
        print("Search")
    }
    
}
    
   
