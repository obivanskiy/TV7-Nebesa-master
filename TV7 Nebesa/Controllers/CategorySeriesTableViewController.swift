//
//  CategorySeriesTableViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/19/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

final class CategorySeriesTableViewController: UITableViewController {
    
    private var presenter: CategorySeriesPresenter?
    private var programmeDataSegue: String = "ProgrammeScreenSegue"
    
    // MARK: - Stored properties
    var seriesData: ProgrammeInformation = ProgrammeInformation() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var seriesProgrammes: SeriesProgrammes = SeriesProgrammes() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var seriesID: String = ""
    var categoryData: CategoryProgrammesData?
    
    //MARK: - View lifecycle functions
    override func viewDidLoad() {
        self.presenter = CategorySeriesPresenter(with: self)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            tableView.estimatedRowHeight = 300
            tableView.rowHeight = UITableView.automaticDimension
            return seriesData.programmeInfo.count
        }
        tableView.estimatedRowHeight = 116
        tableView.rowHeight = UITableView.automaticDimension
        return seriesProgrammes.seriesProgrammes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SeriesInfoTableViewCell.identifier, for: indexPath) as? SeriesInfoTableViewCell else {
                return UITableViewCell()
            }
            cell.cellModel = seriesData.programmeInfo[indexPath.row]
            
            return cell
        } else if indexPath.row >= 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeInfoTableViewCell.identifier, for: indexPath) as? EpisodeInfoTableViewCell else {
                return UITableViewCell()
            }
            cell.cellModel = seriesProgrammes.seriesProgrammes[indexPath.row]
            print(cell.cellModel)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! EpisodeInfoTableViewCell
        tableView.beginUpdates()
        cell.episodeDescriptionLabel.numberOfLines = (cell.episodeDescriptionLabel.numberOfLines == 0) ? 2 : 0
        tableView.endUpdates()
        performSegue(withIdentifier: programmeDataSegue, sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == programmeDataSegue {
//            guard  segue.destination is ProgrammeScreenViewController else {
//                return
//            }
//            guard let indexPath = self.tableView.indexPathForSelectedRow else {
//                return
//            }
//            ProgrammeScreenViewController.programmeData = seriesProgrammes.seriesProgrammes[indexPath.row]
//        }
//    }
}
