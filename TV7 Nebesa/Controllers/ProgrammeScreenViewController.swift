//
//  ProgrammeScreenViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/1/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class ProgrammeScreenViewController: UIViewController {
    
    static var programmeData: ProgrammesData = ProgrammesData()
   
    //MARK: - Outlets
    @IBOutlet weak var programmeView: UIView!
    @IBOutlet weak var seriesNameLabel: UILabel!
    @IBOutlet weak var seriesProgrammeName: UILabel!
    @IBOutlet weak var programmeCaption: UILabel!
    @IBOutlet weak var programmeNumberLabel: UILabel!
    @IBOutlet weak var programmeLenghtLabel: UILabel!
    
    //MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    //MARK: -Set up the UI
    func setUpUI() {
        seriesNameLabel.text = ProgrammeScreenViewController.programmeData.seriesName
        seriesProgrammeName.text = ProgrammeScreenViewController.programmeData.name
        programmeCaption.text = ProgrammeScreenViewController.programmeData.caption
        programmeNumberLabel.text = "Эпизод: \(ProgrammeScreenViewController.programmeData.episodeNumber)"
        programmeLenghtLabel.text = "Длительность: \(dateFormatter(ProgrammeScreenViewController.programmeData.duration))"
    }
    
    private func dateFormatter(_ dateIn: String) -> String {
        guard let unixDate = Double(dateIn) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let newDate = dateFormatter.string(from: date)
        return newDate
    }

    // MARK: - Navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == programmeDataSegue {
//            guard let viewController = segue.destination as? CategorySeriesTableViewController else {
//                return
//            }
//            guard let indexPath = self.tableView.indexPathForSelectedRow else {
//                return
//            }
//    }
////
//}
}
