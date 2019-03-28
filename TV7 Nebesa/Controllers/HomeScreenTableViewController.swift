//
//  HomeScreenTableViewController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/20/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class HomeScreenTableViewController: UITableViewController {

    
    var menuVC: MenuTableViewController!
    
    private(set) var homeScreenData: HomeScreenProgrammes = HomeScreenProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        
//        setupSearchController()
        
        tableView.rowHeight = 130
        
        
        menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as! MenuTableViewController
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToGesture(gesture: UISwipeGestureRecognizer) {
        
        switch gesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            print("Show Menu")
            showMenu()
        case UISwipeGestureRecognizer.Direction.left:
            print("Close Menu")
            closeOnSwipe()
        default:
            break
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        homeScreenDownloadService(homeScreenData: HomeScreenData())
        self.title = "Небеса"

    }
    
    
    
//    //MARK: - Setup Search Controller
    func setupSearchController() {
       
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.isTranslucent = false
        navigationItem.searchController = searchController
    
        definesPresentationContext = true
        
    }
    
    func setupNavigationController() {
        let nav = navigationController!
        let bar = nav.navigationBar
        bar.prefersLargeTitles = true
        
        let item = navigationItem
        item.title = "First View"
        let button = UIBarButtonItem()
        button.title = "Close"
        item.rightBarButtonItem = button
        
        
//
//        let image: UIImage = UIImage(named: "Bitmap.png")!
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = image
//        self.navigationItem.titleView = imageView
//

    }
    
    func homeScreenDownloadService(homeScreenData: HomeScreenData) {
        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.homeScreenDataURL
        guard let url = URL(string: urlToParse) else {
            return
        }
        let urlSessionTask = URLSession.shared.dataTask(with: url) { data, response, error  in
            guard error == nil else {
                return
            }
            guard let responseData = data else {
                return
            }
            do {
                self.homeScreenData = try JSONDecoder().decode(HomeScreenProgrammes.self, from: responseData)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        urlSessionTask.resume()
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return homeScreenData.homeScreenProgrammes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell", for: indexPath) as? HomeScreenTableViewCell else {
            return UITableViewCell()
        }
        cell.cellModel = homeScreenData.homeScreenProgrammes[indexPath.row]
        
        return cell
    }
    
    
    @IBAction func menuAction(_ sender: UIBarButtonItem) {
        
        if AppDelegate.menuIsOpen {
            showMenu()
        } else {
            closeMenu()
        }
        
    }
    
    func closeOnSwipe() {
        if AppDelegate.menuIsOpen {
//            showMenu()
        } else {
            closeMenu()
        }
    }
    
    func showMenu() {
        
        UIView.animate(withDuration: 0.3) { ()->Void in
            self.menuVC.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width
                , height: UIScreen.main.bounds.size.height)
            self.menuVC.view.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.addChild(self.menuVC)
            self.view.addSubview(self.menuVC.view)
            AppDelegate.menuIsOpen = false
        }
        
    }
    
    func closeMenu() {
        UIView.animate(withDuration: 0.5, animations: {
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width
                , height: UIScreen.main.bounds.size.height)
        }) { (finished) in
             self.menuVC.view.removeFromSuperview()
        }
       
        AppDelegate.menuIsOpen = true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
