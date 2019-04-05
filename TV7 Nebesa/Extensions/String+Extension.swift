//
//  String+Extension.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 4/2/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


extension String {
    func encodeUrl() -> String? {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    
    func decodeUrl() -> String? {
        return self.removingPercentEncoding
    }
    
    func timeFormatter(time: String) -> String {
        guard let unixDate = Double(time) else { return "" }
        let date = Date(timeIntervalSince1970: unixDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
}

