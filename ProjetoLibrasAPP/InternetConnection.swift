//
//  InternetConnection.swift
//  ReachabilityTest
//
//  Created by André Rodrigues de Jesus on 11/18/15.
//  Copyright © 2015 André Rodrigues de Jesus. All rights reserved.
//

import Foundation
import UIKit

let kREACHABLEWITHWIFI = "ReachableWithWIFI"
let kNOTREACHABLE = "NotReachable"
let kREACHABLEWITHWWAN = "ReachableWithWWAN"

var reachability:Reachability?
var reachabilityStatus = kREACHABLEWITHWIFI

class InternetConnection:UIViewController {
    
    var internetReach:Reachability?
    
    func verifyInternetStatus() {
        internetReach = Reachability.reachabilityForInternetConnection()
        internetReach?.startNotifier()
        
        if internetReach != nil {
            statusChangedWithReachability(internetReach!)
        }

    }
    
    func reachabilityChanged(notification: NSNotification) {
        print("Reachability Status Changed...")
        reachability = notification.object as? Reachability
        statusChangedWithReachability(reachability!)
    }
    
    func statusChangedWithReachability(currentReachabilityStatus: Reachability) {
        let networkStatus:NetworkStatus = currentReachabilityStatus.currentReachabilityStatus()
        
        print("Status value: \(networkStatus.rawValue)")
        
        if networkStatus.rawValue == NotReachable.rawValue {
            print("Network Not Reachable!")
            reachabilityStatus = kNOTREACHABLE
        }
        else if networkStatus.rawValue == ReachableViaWiFi.rawValue {
            print("Network reachable with WIFI!")
            reachabilityStatus = kREACHABLEWITHWIFI
        }
        else if networkStatus.rawValue == ReachableViaWWAN.rawValue {
            print("Network reachable with WWan!")
            reachabilityStatus = kREACHABLEWITHWWAN
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("ReachStatusChanged", object: nil)
        
    }
    
    func reachabilityStatusChanged() {
        if reachabilityStatus == kNOTREACHABLE {
            print("Sem net!")
        }
    }
        
}