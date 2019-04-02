//
//  WebTVScreenViewController.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/2/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit
import AVFoundation
import  AVKit

class WebTVScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - player properties
    private var webTVPLayer: AVPlayer!
    private var webTVPlayerViewController = AVPlayerViewController()
    private var ruStreamLink: String = NetworkEndpoints.webTVLiveBaseURL + NetworkEndpoints.webTVLiveRUEndpoint
    
    //MARK: - Outlets
    @IBOutlet weak var webTVStreamView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        player(urlString: ruStreamLink)
    }
    
    private func player(urlString: String) {
        if let  videoURL = URL(string: urlString.encodeUrl()!) {
            self.webTVPLayer = AVPlayer(url: videoURL)
            webTVPlayerViewController.player = self.webTVPLayer
            webTVPlayerViewController.view.frame = webTVStreamView.bounds
            self.addChild(webTVPlayerViewController)
            webTVStreamView.addSubview(webTVPlayerViewController.view)
            webTVPlayerViewController.didMove(toParent: self)
            webTVPlayerViewController.player?.play()
        }
    }

    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
