//
//  LocationManager.swift
//  Map With Direction
//
//  Created by Mac on 9/27/17.
//  Copyright © 2017 AtulPrakash. All rights reserved.
//

import Foundation


import MapKit

protocol LocationUpdateProtocol {
    func locationDidUpdateToLocation(location : CLLocation)
}

class LocationManager: NSObject {
    
    static let SharedManager = LocationManager()
    private var locationManager:CLLocationManager! = CLLocationManager()
    var currentLocation : CLLocation?
    var delegate : LocationUpdateProtocol!
    
    private override init () {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager.distanceFilter = 10.0 //call update location only after 10 meter change
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
}

extension LocationManager:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            DispatchQueue.main.async() { () -> Void in
                self.delegate.locationDidUpdateToLocation(location: self.currentLocation!)
            }
        }
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}
