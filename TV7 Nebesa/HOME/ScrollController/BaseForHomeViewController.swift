//
//  NebessaScreenController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/4/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class BaseForHomeViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private var presenter: BaseRecommendPresenter?
    
    private var homeScreenProgrammeDataSegue: String = "HomeScreenProgrammePageSegue"
    
    var homeScreenProgrammeInfo: HomeScreenProgrammeInformation = HomeScreenProgrammeInformation() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var homeScreenData: HomeScreenProgrammes = HomeScreenProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
   
    var homeScreenNewestData: HomeScreenNewestProgrammes = HomeScreenNewestProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var homeScreenMostViewedData: HomeScreenMostViewedProgrammes = HomeScreenMostViewedProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    let tableView = UITableView()
    let titleItem = "Небеса"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = BaseRecommendPresenter(with: self)
        
        setupMenuBar()
        setupNavBarButtons()
        setupNavigationItems()
        title = titleItem
        tableView.dataSource = self
        tableView.delegate = self
        
        //late parser
        //        homeScreenDownloadService(homeScreenData: HomeScreenData())
        
    }

    //MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return homeScreenData.homeScreenProgrammes.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell", for: indexPath) as? HomeScreenTableViewCell else {
            return UITableViewCell()
        }
        cell.cellModel = homeScreenData.homeScreenProgrammes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! HomeScreenTableViewCell
        //        tableView.beginUpdates()
        //        cell.episodeDescriptionLabel.numberOfLines = (cell.episodeDescriptionLabel.numberOfLines == 0) ? 2 : 0
        //        tableView.endUpdates()
        HomeVideoPlayerController.programInfo = cell.cellModel ?? HomeScreenData()
        performSegue(withIdentifier: homeScreenProgrammeDataSegue, sender: self)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if(velocity.y>0) {
            //Code will work without the animation block.I am using animation block incase if you want to set any delay to it.
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                //                self.navigationController?.setToolbarHidden(true, animated: true)
                print("Hide")
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0, options: UIView.AnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                //                self.navigationController?.setToolbarHidden(false, animated: true)
                print("Unhide")
            }, completion: nil)
        }
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
        //        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.addSubview(statusBarMask)
        
        statusBarMask.topAnchor.constraint(equalTo: view.topAnchor)
    }
    
    
    
    func setupNavigationItems() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = titleItem
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
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
    
    
    //computed
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    //:MARK - SETUP PRIVATE MENUBAR
    private func setupMenuBar() {
        
        
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 12, green: 100, blue: 194)
        view.addSubview(redView)
        view.addConstraintsWithFormat(withVisualFormat: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(withVisualFormat: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(withVisualFormat: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(withVisualFormat: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    
    
    
    
    
    //late parser
    //    func homeScreenDownloadService(homeScreenData: HomeScreenData) {
    //        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.homeScreenDataURL
    //        guard let url = URL(string: urlToParse) else {
    //            return
    //        }
    //        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error  in
    //            guard error == nil else {
    //                return
    //            }
    //            guard let responseData = data else {
    //                return
    //            }
    //            do {
    //                self.homeScreenData = try JSONDecoder().decode(HomeScreenProgrammes.self, from: responseData)
    //            } catch let error {
    //                print(error.localizedDescription)
    //            }
    //        }
    //        urlSessionTask.resume()
    //    }
    
    
    
    
    
    //    func setupNavBarButtons() {
    //        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
    //        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
    //
    //        let moreButton = UIBarButtonItem(image: UIImage(named: "tvIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
    //
    //
    //        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonItem]
    //    }
    //    @objc func handleMore() {
    //
    //    }
    //
    //    @objc func handleSearch() {
    //        print("Search")
    //    }
    
}
