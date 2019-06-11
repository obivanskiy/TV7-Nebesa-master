//
//  UIViewController+Extension.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 5/6/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showDefaultAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
