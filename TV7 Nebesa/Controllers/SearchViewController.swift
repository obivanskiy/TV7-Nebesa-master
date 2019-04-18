//
//  SearchViewController.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/18/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!

    //MARK: - Properties
    var searchResults: SearchResults = SearchResults() {
        didSet {
            DispatchQueue.main.async {
                self.searchResultsTableView.reloadData()
            }
        }
    }
    private var presenter: SearchResultsPresenter?

    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }

    //MARK: Search Bar Delegate Methods
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.tintColor = .clear
        self.searchBar.backgroundColor = .clear
        self.searchBar.showsCancelButton = false
        self.searchBar.text?.removeAll()
        searchResultsTableView.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let userText = searchBar.text
        presenter = SearchResultsPresenter(with: self, userText: userText ?? "")
        searchResultsTableView.reloadData()
        searchResultsTableView.endEditing(true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }



    //MARK: - Table View Data Source Methods
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: SearchSeriesCell.identifier, for: indexPath) as? SearchSeriesCell else {
            return UITableViewCell()
        }
        cell.cellModel = searchResults.results[indexPath.row]
        return cell
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.showsCancelButton = false
    }

    //MARK: - Actions
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        searchBar.endEditing(true)
        self.dismiss(animated: true) {
            let _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }

    //MARK: - Private Methods
    private func setupTableView() {
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.keyboardDismissMode = .onDrag
        //Register for SearchSeriesCell.xib
        searchResultsTableView.register(UINib(nibName: SearchSeriesCell.identifier, bundle: .none), forCellReuseIdentifier: SearchSeriesCell.identifier)
        searchResultsTableView.register(UINib(nibName: SearchEpisodeCell.identifier, bundle: .none), forCellReuseIdentifier: SearchEpisodeCell.identifier)
        searchResultsTableView.estimatedRowHeight = 200
        searchResultsTableView.rowHeight = UITableView.automaticDimension
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }


}
