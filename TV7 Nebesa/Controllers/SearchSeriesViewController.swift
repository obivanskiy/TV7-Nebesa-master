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
    @IBOutlet weak var seriesImage: UIView!
    @IBOutlet weak var seriesNameLabel: UILabel!
    @IBOutlet weak var seriesDescriptionLabel: UILabel!

    //MARK: - Properties
    var dataForTopContentDictionary: [String: String] = [:]

    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print(dataForTopContentDictionary)
    }

    //MARK: - Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }

    //MARK: - Table View Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    //MARK: - Private Methods
    private func setupUI() {
        seriesTableView.delegate = self
        seriesTableView.dataSource = self
        seriesNameLabel.text = dataForTopContentDictionary["name"]
    }

}
