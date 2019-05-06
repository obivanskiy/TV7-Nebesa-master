//
//  SearchViewController.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/18/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {


    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultsTableView: UITableView!

    // MARK: - Properties
    var searchResults: SearchResults = SearchResults() {
        didSet {
            DispatchQueue.main.async {
                self.searchResultsTableView.reloadData()
            }
        }
    }
    var searchEpisode: SearchEpisode = SearchEpisode()
    private var presenter: SearchResultsPresenter?
    private var presenterEpisode: SearchEpisodePresenter?
    private var programmeDataSegue = "ProgrammeScreenSegue"
    private let episodeSegue = "episodeSegue"
    private let seriesSegue = "seriesSegue"

    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
    }

    // MARK: Search Bar Delegate Methods
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
        self.definesPresentationContext = true
    }

    // MARK: - Table View Data Source Methods
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

    // MARK: Table View Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let typeOfContent = searchResults.results[indexPath.row].type
        switch typeOfContent {
        case "episode":
            performSegue(withIdentifier: episodeSegue, sender: self)
            print("Did select = episode")
        case "series":
            performSegue(withIdentifier: seriesSegue, sender: self)
            print("Did select = series")
        default:
            print("There is no type found")
        }
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.showsCancelButton = false
    }

    // MARK: - Actions
    @IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
        searchBar.endEditing(true)
        self.dismiss(animated: true) {
            let _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            assertionFailure("Identifier not found")
            return
        }
        switch identifier {
        case episodeSegue:
            guard let indexPath = self.searchResultsTableView.indexPathForSelectedRow else { return }
            guard let destVC = segue.destination as? SearchEpisodeViewController else { return }

            destVC.episodeId = searchResults.results[indexPath.row].id
            print("Episode id for EpisodeVC: \(destVC.episodeId)")
        case seriesSegue:
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
        //Register for SearchSeriesCell.xib and SearchEpisodeCell.xib
        searchResultsTableView.register(UINib(nibName: SearchSeriesCell.identifier, bundle: .none), forCellReuseIdentifier: SearchSeriesCell.identifier)
        searchResultsTableView.register(UINib(nibName: SearchEpisodeCell.identifier, bundle: .none), forCellReuseIdentifier: SearchEpisodeCell.identifier)
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
        } else {
            showDefaultAlert(title: "Sorry", message: "You have no internet connection.")
            print("Internet Connection not Available!")
        }
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }


}
