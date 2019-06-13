//
//  InternetConnection.swift
//  TV7 Nebesa
//
//  Created by Alexandr on 5/6/19.
//  Copyright © 2019 Богдан Воробйовський. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import SVProgressHUD

class Reachability {

    class func isConnectedToNetwork() -> Bool {

        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }

        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)

        return ret

    }
}

protocol InternetConnection: UIViewController {
    func checkInternetConnection()
}

extension InternetConnection {
    func checkInternetConnection() {
        if !Reachability.isConnectedToNetwork() {
            SVProgressHUD.dismiss()
            showDefaultAlert(title: "Sorry", message: "You have no internet connection")
            print("Internet Connection not Available!")
        }
    }
}
