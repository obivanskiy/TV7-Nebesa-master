//
//  NebessaScreenController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/4/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class NebessaScreenController : BaseHomeController, UITableViewDataSource, UITableViewDelegate {
  
    private var presenter: HomeScreenPresenter?
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
   
    
    let tableView = UITableView()
    let titleItem = "Небеса"
    
        // Data for VideoPlayer Screen
//    var homeScreenProgrammeInformation: HomeScreenProgrammeInformation = HomeScreenProgrammeInformation() {
//        didSet {
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = HomeScreenPresenter(with: self)
        
        setupMenuBar()
        setupNavigationItems()
        title = titleItem
        tableView.dataSource = self
        tableView.delegate = self
        
        //late parser
//        homeScreenDownloadService(homeScreenData: HomeScreenData())
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
   

    // MARK: - Table view data source
    
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
    
    func setupNavigationItems() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = titleItem
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    
    //computed
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    //:MARK - SETUP PRIVATE MENUBAR
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(withVisualFormat: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(withVisualFormat: "V:|[v0(50)]", views: menuBar)
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
