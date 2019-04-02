//
//  Extensions.swift
//  TV7 Nebesa
//
//  Created by Богдан Воробйовський on 4/2/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

// extension for subviews constraints(in cell)
extension UIView {
    func addConstraintsWithFormat(withVisualFormat: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        // loop through views
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            print("ViewDictionaryKey,\(key)")
            
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: withVisualFormat, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
