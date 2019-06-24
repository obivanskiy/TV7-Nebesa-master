//
//  RootContainerViewController.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 3/12/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.

import GoogleCast
import UIKit

let kCastControlBarsAnimationDuration: TimeInterval = 0.20

@objc(RootContainerViewController)
class RootContainerViewController: UIViewController, GCKUIMiniMediaControlsViewControllerDelegate {
    
    @IBOutlet var bottomBarForX: UIView!
    @IBOutlet weak var statusBarContainer: UIView!
    @IBOutlet private var _miniMediaControlsContainerView: UIView!
    @IBOutlet private var _miniMediaControlsHeightConstraint: NSLayoutConstraint!
    private var miniMediaControlsViewController: GCKUIMiniMediaControlsViewController!
    var miniMediaControlsViewEnabled = false {
        didSet {
            if isViewLoaded {
                updateControlBarsVisibility()
            }
        }
    }
    
    var overridenNavigationController: UINavigationController?
    override var navigationController: UINavigationController? {
        get {
            return overridenNavigationController
        }
        set {
            overridenNavigationController = newValue
        }
    }
    
    var miniMediaControlsItemEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomBarForX.backgroundColor =  UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1) //12
        bottomBarForX.tintColor = UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1) //12
        statusBarContainer.backgroundColor =  UIColor(red: 12/255 , green: 100/255 , blue: 194/255 , alpha: 1) //12
        let castContext = GCKCastContext.sharedInstance()
        miniMediaControlsViewController = castContext.createMiniMediaControlsViewController()
        miniMediaControlsViewController.delegate = self
        updateControlBarsVisibility()
        installViewController(miniMediaControlsViewController,
                              inContainerView: _miniMediaControlsContainerView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Internal methods
    
    func updateControlBarsVisibility() {
        if miniMediaControlsViewEnabled, miniMediaControlsViewController.active {
            _miniMediaControlsHeightConstraint.constant = miniMediaControlsViewController.minHeight
            view.bringSubviewToFront(_miniMediaControlsContainerView)
        } else {
            _miniMediaControlsHeightConstraint.constant = 0
        }
        UIView.animate(withDuration: kCastControlBarsAnimationDuration, animations: { () -> Void in
            self.view.layoutIfNeeded()
        })
        view.setNeedsLayout()
    }
    
    func installViewController(_ viewController: UIViewController?, inContainerView containerView: UIView) {
        if let viewController = viewController {
            addChild(viewController)
            viewController.view.frame = containerView.bounds
            containerView.addSubview(viewController.view)
            viewController.didMove(toParent: self)
        }
    }
    
    func uninstallViewController(_ viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "NavigationVCEmbedSegue" {
            navigationController = (segue.destination as? UINavigationController)
        }
    }
    
    // MARK: - GCKUIMiniMediaControlsViewControllerDelegate
    
    func miniMediaControlsViewController(_: GCKUIMiniMediaControlsViewController,
                                         shouldAppear _: Bool) {
        updateControlBarsVisibility()
    }
}

