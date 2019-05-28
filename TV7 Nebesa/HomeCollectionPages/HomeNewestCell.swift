//
//  NewestHomeCell.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/17/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class HomeNewestCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate{
    var myViewController : HomeBaseViewController!
    @IBOutlet weak var newestTableView: UITableView!
    
    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
 
    var isDataLoading:Bool=false
    var pageNo:Int=0
    var limit:Int=20
    var offset:Int=0 //pageNo*limit
    var didEndReached:Bool=false
    
   private var presenterForNewest: HomeNewestPresenter?
   var homeScreenNewestData: HomeScreenNewestProgrammes = HomeScreenNewestProgrammes() {
        didSet {
            DispatchQueue.main.async {
                
                self.newestTableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    override func awakeFromNib() {
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .gray
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.presenterForNewest = HomeNewestPresenter(with: self)
        setupTableView()
        
    }
    
    func setupTableView() {
        //        homeScreenDownloadService(homeScreenData: HomeScreenData())
        newestTableView.dataSource = self
        newestTableView.delegate = self
//        print(homeScreenNewestData.homeScreenNewestProgrammes)
//        newestTableView.contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)
//        newestTableView.scrollIndicatorInsets = .init(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeScreenNewestData.homeScreenNewestProgrammes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = newestTableView.dequeueReusableCell(withIdentifier: "newestCellId", for: indexPath) as? NewestTableViewCell else {
            return UITableViewCell()
        }
        cell.cellModel = homeScreenNewestData.homeScreenNewestProgrammes[indexPath.row]
        
        print(homeScreenNewestData.homeScreenNewestProgrammes)
       
        return cell
        
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        let cell = tableView.cellForRow(at: indexPath) as! NewestTableViewCell
//    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        print("scrollViewWillBeginDragging")
        isDataLoading = false
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
    }
    //Pagination
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        print("scrollViewDidEndDragging")
        
        if ((newestTableView.contentOffset.y + newestTableView.frame.size.height) >= newestTableView.contentSize.height)
        {
            if !isDataLoading{
                isDataLoading = true
                self.pageNo=self.pageNo+1
                self.limit=self.limit+10
                self.offset=self.limit * self.pageNo
                NetworkService.requestURL[.fetchHomeScreenNewestProgrammes] = NetworkEndpoints.baseURL + NetworkEndpoints.homeScreenNewestProgrammesURL + "&limit=\(limit)" + "&offset=\(offset)"
                reloadInputViews()
            }
        }
        
        
    }
}
