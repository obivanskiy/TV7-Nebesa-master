//
//  HomeBaseViewController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/11/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

let cellId = "homeCell"
let newestCellId = "homeNewestCell"
let mostViewedCellId = "mostViewedCell"
var titleItem = ""

class HomeBaseViewController: BaseHomeController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate {
    
    @IBOutlet weak var homePageCollectionView: UICollectionView!
    
    private var homeScreenProgrammeDataSegue: String = "HomeScreenProgrammePageSegue"
    //    private var presenterForRecommend: HomeRecommendPresenter?
    //    private var presenterForNewest: HomeNewestPresenter?
    //    private var presenterForMostViewed: HomeMostViewedPresenter?
    //    var homeScreenData: HomeScreenProgrammes = HomeScreenProgrammes()
    //    var homeScreenNewestData: HomeScreenNewestProgrammes = HomeScreenNewestProgrammes()
    //    var homeMostViewedData: HomeScreenMostViewedProgrammes = HomeScreenMostViewedProgrammes()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuBar()
        setupNavigationItems()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Небеса ТВ7"
    }
    
    //UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0;
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0;
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
  
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        homePageCollectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
}
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mostViewedCellId, for: indexPath) as! HomeMostViewedCell
//            vc.titleItem = "Топовые"
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: newestCellId, for: indexPath) as! HomeNewestCell
//            vc.vctitleItem = "Новые"
            return cell
        } 
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeRecommendCell
//        vc.titleItem = "Рекомедованные"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width , height: view.frame.height - 50)
        //TODO: - landscape orientation
    }
    
    
    // custom function to generate a random UIColor
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    //computed
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    //:MARK - SETUP PRIVATE MENUBAR
    private func setupMenuBar() {
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 12, green: 100, blue: 194)
        view.addSubview(redView)
        view.addConstraintsWithFormat(withVisualFormat: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(withVisualFormat: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(withVisualFormat: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(withVisualFormat: "V:[v0(50)]", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    func setupNavigationItems() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = titleItem
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    // MARK: - Navigation
    
    private enum SegueIdentifier: String {
        case videoDataSegue
    }
    
    var collectionView: UICollectionView {
        // FIXME: IBOutlet to UICollectionView
        let subviews = view.subviews.compactMap { $0 as? UICollectionView }
        return subviews.first!
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier.flatMap(SegueIdentifier.init) else {
            return
        }
        switch identifier {
        case .videoDataSegue:
            guard let sender = sender else { return }
            let destination = segue.destination as! HomeVideoPlayerController
            switch sender {
            case let tableCell as RecommendTableViewCell:
                let collectionCell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! HomeRecommendCell
                let indexPath = collectionCell.recommendTableView.indexPath(for: tableCell)
                let data = collectionCell.homeScreenData.homeScreenProgrammes[indexPath!.row]
                destination.title = data.seriesName
                if data.description != "" {
                    destination.videoCaption = data.description
                } else {
                     destination.videoCaption = data.caption
                }
                destination.videoTitle = data.name
                destination.videoURLString = NetworkEndpoints.baseURLForVideoPlayback + data.linkPath + NetworkEndpoints.playlistEndpoint
                print(destination.videoURLString)
                destination.videoDuration = data.duration
                destination.videoFirstBroadcast = data.firstBroadcast
                destination.videoEpisodeNumber = data.episodeNumber
                
            case let tableCell as NewestTableViewCell:
                let collectionCell = collectionView.cellForItem(at: IndexPath(item: 1, section: 0)) as! HomeNewestCell
                let indexPath = collectionCell.newestTableView.indexPath(for: tableCell)
                let data = collectionCell.homeScreenNewestData.homeScreenNewestProgrammes[indexPath!.row]
                destination.title = data.seriesName
//                if data.description != "" {
//                    destination.videoCaption = data.description
//                } else {
                    destination.videoCaption = data.caption
                
                destination.videoTitle = data.name
                destination.videoURLString = NetworkEndpoints.baseURLForVideoPlayback + data.linkPath! + NetworkEndpoints.playlistEndpoint
                print(destination.videoURLString)
                destination.videoDuration = data.duration!
                destination.videoFirstBroadcast = data.firstBroadcast
                destination.videoEpisodeNumber = data.episodeNumber!
           
            case let tableCell as MostViewedTableViewCell:
                let collectionCell = collectionView.cellForItem(at: IndexPath(item: 2, section: 0)) as! HomeMostViewedCell
                let indexPath = collectionCell.mostViewedTableView.indexPath(for: tableCell)
                let data = collectionCell.homeMostViewedData.homeScreenMostViewedProgrammes[indexPath!.row]
                destination.title = data.seriesName
                //                if data.description != "" {
                //                    destination.videoCaption = data.description
                //                } else {
                destination.videoCaption = data.caption
                
                destination.videoTitle = data.programName
//                destination.videoURLString = NetworkEndpoints.baseURLForVideoPlayback + data.! + NetworkEndpoints.playlistEndpoint
//                print(destination.videoURLString)
                destination.videoDuration = data.time!
//                destination.videoFirstBroadcast = data.
                destination.videoEpisodeNumber = data.episodeNumber!
            default:
                break
            }
        }
    }
}
