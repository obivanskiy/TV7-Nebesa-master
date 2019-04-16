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

    //MARK: - Properties
    var searchResults: SearchResults = SearchResults() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private var presenter: SearchResultsPresenter?

    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.keyboardDismissMode = .onDrag
        tableView.reloadData()
    }

    //MARK: Search Bar Delegate Methods
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.showsCancelButton = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        self.searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        self.searchBar.showsCancelButton = false
        let userText = searchBar.text
        presenter = SearchResultsPresenter(with: self, userText: userText ?? "")
        print("It is users text: \(userText!)")
        print("Search results count: \(searchResults.results)")
    }

    //MARK: - Table View Data Source Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.results.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }

    //MARK: - Actions
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        searchBar.endEditing(true)
        self.dismiss(animated: true) {
            let _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }

}
