//
//  SearchViewController.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/18/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import SVProgressHUD

final class SearchViewController: UIViewController, InternetConnection {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!

    // MARK: - Properties
    var searchResults: SearchResults = SearchResults() {
        didSet {
            DispatchQueue.main.async {
                self.searchResultsTableView.reloadData()
                SVProgressHUD.dismiss()
                if self.searchResults.results.isEmpty {
                    guard let searchText = self.searchBar.text else { return }
                    self.showDefaultAlert(title: "Sorry", message: "There is no information for your request: '\(searchText)'")
                }
            }
        }
    }
    var searchEpisode: SearchEpisode = SearchEpisode()
    private var presenter: SearchResultsPresenter?
    private var presenterEpisode: SearchEpisodePresenter?
    private enum Constants {
        static let programmeDataSegue = "ProgrammeScreenSegue"
        static let episodeSegue = "episodeSegue"
        static let seriesSegue = "seriesSegue"
    }
    private var searchDelayer = Timer()

    // MARK: - Lifecycle <ethods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SVProgressHUD.dismiss()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            assertionFailure("Identifier not found")
            return
        }
        switch identifier {
        case Constants.episodeSegue:
            guard let indexPath = self.searchResultsTableView.indexPathForSelectedRow else { return }
            guard let destVC = segue.destination as? SearchEpisodeViewController else { return }

            destVC.episodeId = searchResults.results[indexPath.row].id
            print("Episode id for EpisodeVC: \(destVC.episodeId)")
        case Constants.seriesSegue:
            guard let indexPath = self.searchResultsTableView.indexPathForSelectedRow else { return }
            guard let destVC = segue.destination as? SearchSeriesViewController else { return }
            let dataForSeries = searchResults.results[indexPath.row]
            destVC.title = dataForSeries.name
            destVC.episodeId = dataForSeries.id
            destVC.dataForTopContentDictionary = ["name": dataForSeries.name, "imagePath": dataForSeries.imagePath, "caption": dataForSeries.caption]
        default:
            assertionFailure("Identifier wasn't recognized")
        }
    }

    // MARK: - Private Methods
    private func setupTableView() {
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.keyboardDismissMode = .onDrag
        searchResultsTableView.tableFooterView = UIView()
        //Register for SearchSeriesCell.xib and SearchEpisodeCell.xib
        searchResultsTableView.register(UINib(nibName: SearchSeriesCell.identifier, bundle: .none), forCellReuseIdentifier: SearchSeriesCell.identifier)
        searchResultsTableView.register(UINib(nibName: SearchEpisodeCell.identifier, bundle: .none), forCellReuseIdentifier: SearchEpisodeCell.identifier)
        checkInternetConnection()
    }

    // Make search when user stop typing
    @objc private func search(_ gesture: UITapGestureRecognizer) {
        guard let searchText = searchDelayer.userInfo as? String else { return }
        if searchDelayer.userInfo != nil && searchText != "" {
            presenter = SearchResultsPresenter(with: self, userText: searchDelayer.userInfo as! String)
        }
        checkInternetConnection()
        searchDelayer.invalidate()
        searchResultsTableView.reloadData()
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }

}

// MARK: - Table View Data Source Methods
extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchResults.results[indexPath.row].type == "series" {
            guard let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: SearchSeriesCell.identifier, for: indexPath) as? SearchSeriesCell else {
                return UITableViewCell()
            }
            cell.cellModel = searchResults.results[indexPath.row]
            return cell
        }
        guard let cell = searchResultsTableView.dequeueReusableCell(withIdentifier: SearchEpisodeCell.identifier, for: indexPath) as? SearchEpisodeCell else {
            return UITableViewCell()
        }
        cell.cellModel = searchResults.results[indexPath.row]
        return cell
    }
}

// MARK: - Table View Delegate Methods
extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let typeOfContent = searchResults.results[indexPath.row].type
        switch typeOfContent {
        case "episode":
            performSegue(withIdentifier: Constants.episodeSegue, sender: self)
            print("Did select = episode")
        case "series":
            performSegue(withIdentifier: Constants.seriesSegue, sender: self)
            print("Did select = series")
        default:
            print("There is no type found")
        }
        searchResultsTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: Search Bar Delegate Methods
extension SearchViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text?.removeAll()
        self.searchBar.showsCancelButton = true
        searchResultsTableView.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let userText = searchBar.text
        presenter = SearchResultsPresenter(with: self, userText: userText ?? "")
        searchResultsTableView.reloadData()
        searchResultsTableView.endEditing(true)
        checkInternetConnection()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        self.definesPresentationContext = true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchDelayer.invalidate()
        searchDelayer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(search(_:)), userInfo: searchText, repeats: false)
    }

}
