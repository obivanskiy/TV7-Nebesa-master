//
//  MenuTableViewController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/26/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  
    let menuItems = ["Home", "WebTV", "Programme", "Archive", "Donate", "Contact Us"]
    

    @IBOutlet weak var menuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    
    // MARK: - Table view data source
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // #warning Incomplete implementation, return the number of rows
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuTableViewCell
        cell.MenuItemLabel.text = menuItems[indexPath.row]
        print("menu")
        return cell
    }

   

}
