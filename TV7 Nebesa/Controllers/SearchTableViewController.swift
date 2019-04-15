//
//  SearchTableViewController.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/15/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var searchResultTableView: UITableView!

    //MARK: - Properties

    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        searchResultTableView.keyboardDismissMode = .onDrag
    }

    //MARK: - Table View Data Source Methods
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
    }

    //MARK: Search Bar Delegate Methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        self.searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.searchBar.showsCancelButton = false
    }

    //MARK: - Actions
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        searchBar.endEditing(true)
        self.dismiss(animated: true) {
            let _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }


}
