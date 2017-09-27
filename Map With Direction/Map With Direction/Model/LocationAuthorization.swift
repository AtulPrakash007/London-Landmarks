//
//  LocationAuthorization.swift
//  Map With Direction
//
//  Created by Mac on 9/26/17.
//  Copyright © 2017 AtulPrakash. All rights reserved.
//

import Foundation
import CoreLocation

class LocationAuthorization:NSObject {
    
    let locationManager = CLLocationManager()
    
    func checkLocationAccess() -> Bool {
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
            
        case .denied, .restricted:
            print("location access denied")
            return false
            
        default:
            return false
        }
    }
}
