//
//  PageViewController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
   
    
    

    lazy var orderedVeiwController: [UIViewController] = {
        return [self.newVc(viewController: "HomeRecommendSB"), self.newVc(viewController: "HomeNewestSB"), self.newVc(viewController: "HomeMostViewedSB")]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        if let firstViewController = orderedVeiwController.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: "HomeScreen", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedVeiwController.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
//            return orderedVeiwController.last
            return nil
        }
        guard orderedVeiwController.count > previousIndex else {
            return nil
        }
        return orderedVeiwController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedVeiwController.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        
        guard orderedVeiwController.count != nextIndex else {
//            return orderedVeiwController.first
            return nil
        }
        guard orderedVeiwController.count > nextIndex else {
            return nil
        }
        return orderedVeiwController[nextIndex]
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
