//
//  URL+Extension.swift
//  TV7 Nebesa
//
//  Created by Ivan Obodovskyi on 3/22/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation


extension URL {
    func asyncDownload(completion: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()) {
        URLSession.shared
            .dataTask(with: self, completionHandler: completion)
            .resume()
    }
}
