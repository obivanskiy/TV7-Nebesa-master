//
//  HomeScreenTableViewController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/20/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class HomeScreenTableViewController: UITableViewController {

    private(set) var homeScreenData: HomeScreenProgrammes = HomeScreenProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 122
        print("1")
    }

    override func viewWillAppear(_ animated: Bool) {
        homeScreenDownloadService(homeScreenData: HomeScreenData())
        self.title = "Небеса"
        setupSearchController()
    }
    
    //MARK: - Setup Search Controller
    func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
    }
    
    func homeScreenDownloadService(homeScreenData: HomeScreenData) {
        let urlToParse = NetworkEndpoints.baseURL + NetworkEndpoints.homeScreenDataURL + homeScreenData.id
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
