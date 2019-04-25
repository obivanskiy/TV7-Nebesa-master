//
//  SearchSeriesViewController.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 4/25/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class SearchSeriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var seriesTableView: UITableView!
    @IBOutlet weak var seriesImage: UIImageView!
    @IBOutlet weak var seriesNameLabel: UILabel!
    @IBOutlet weak var seriesCaptionLabel: UILabel!

    //MARK: - Properties
    var dataForTopContentDictionary: [String: String] = [:]
    var episodeId = ""
    var searchSeriesData: SeriesProgrammes = SeriesProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.seriesTableView.reloadData()
            }
        }
    }
    private var episodeSegue = "episodeSegue"
    private var presenter: SearchSeriesPresenter?

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    //MARK: - Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchSeriesData.seriesProgrammes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = seriesTableView.dequeueReusableCell(withIdentifier: SearchEpisodeCell.identifier, for: indexPath) as? SearchEpisodeCell else {
            return UITableViewCell()
        }
        cell.seriesCellModel = searchSeriesData.seriesProgrammes[indexPath.row]
        return cell
    }

    //MARK: - Table View Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: episodeSegue, sender: self)
    }

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = self.seriesTableView.indexPathForSelectedRow else { return }
        guard let destVC = segue.destination as? SearchEpisodeViewController else { return }
        destVC.episodeId = searchSeriesData.seriesProgrammes[indexPath.row].id
        print("Episode id for EpisodeVC: \(destVC.episodeId)")
    }

    //MARK: - Private Methods
    private func setupUI() {
        seriesTableView.delegate = self
        seriesTableView.dataSource = self
        seriesCaptionLabel.numberOfLines = 5
        seriesNameLabel.text = dataForTopContentDictionary["name"]
        seriesCaptionLabel.text = dataForTopContentDictionary["caption"]
        guard let previewImageURL = URL.init(string: dataForTopContentDictionary["imagePath"] ?? "") else { return }
        seriesImage.kf.setImage(with: previewImageURL)
        presenter = SearchSeriesPresenter(with: self, episodeId: episodeId)
       //Register for SearchEpisodeCell.xib
        seriesTableView.register(UINib(nibName: SearchEpisodeCell.identifier, bundle: .none), forCellReuseIdentifier: SearchEpisodeCell.identifier)
    }

}
