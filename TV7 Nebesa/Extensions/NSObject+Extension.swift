//
//  NSObject+Extension.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 6/5/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

var vSpinner : UIView?

extension UIViewController {
    
    func showActivityIndicator(onView: UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicator)
            onView.addSubview(spinnerView)
        }

        vSpinner = spinnerView
    }

    func removeActivityIndicator() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
