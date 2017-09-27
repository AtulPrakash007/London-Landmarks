//
//  LocateViewController.swift
//  Map With Direction
//
//  Created by Mac on 9/25/17.
//  Copyright © 2017 AtulPrakash. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

enum MapType: NSInteger {
    case StandardMap = 0
    case SatelliteMap = 1
    case HybridMap = 2
}

class LocateViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    //Map Variables
    var currentLocation : CLLocation!
    var locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    var region = MKCoordinateRegion()
    
    //Custom Class Intializer
    let locationAuthorization = LocationAuthorization()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check location access
        if locationAuthorization.checkLocationAccess(){
            
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
        
        LocationManager.SharedManager.delegate = self
        
        // map View initial setting
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.showsScale = true
        mapView.showsCompass = true
        mapView.isZoomEnabled = true
//        mapView.userTrackingMode = .follow
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if locationAuthorization.checkLocationAccess(){
            
        }else{
            region = MKCoordinateRegion(center: KDefaultLocation.coordinate, span: kSpan)
            annotation.coordinate = KDefaultLocation.coordinate
            mapView.addAnnotation(annotation)
            mapView.setRegion(region, animated: true)
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        LocationManager.SharedManager.stopUpdatingLocation()
    }
    
    @IBAction func locateAction(_ sender: Any) {
        if locationAuthorization.checkLocationAccess(){
            region = MKCoordinateRegion(center: currentLocation.coordinate, span: kSpan)
            mapView.setRegion(region, animated: true)
        }else{
            //Show Alert
        }
    }
    
    @IBAction func directionAction(_ sender: Any) {
        //Check location access
        var urlSring:String = ""
        if locationAuthorization.checkLocationAccess(){
            //saddr - from & daddr - to
             urlSring = "http://maps.apple.com/maps?saddr=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
        }else{
             urlSring = "http://maps.apple.com/maps?saddr=\(KDefaultLocation.coordinate.latitude),\(KDefaultLocation.coordinate.longitude)"
        }
        let url = URL(string: urlSring)!
        
        // It will directly open the Default Map with the option to as given url with search option
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            print("Error in opening")
        }
    }
    
    @IBAction func mapChangeSegmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case MapType.StandardMap.rawValue:
            mapView.mapType = .standard
        case MapType.SatelliteMap.rawValue:
            mapView.mapType = .satellite
        case MapType.HybridMap.rawValue:
            mapView.mapType = .hybrid
        default:
            mapView.mapType = .standard
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
}

//------------------------------------------------------
// MARK: - MKMapViewDelegate
//------------------------------------------------------

extension LocateViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView .setCenter(userLocation.coordinate, animated: true)
        annotation.coordinate = userLocation.coordinate
        mapView.addAnnotation(annotation)
    }
}

//------------------------------------------------------
// MARK: - LocationUpdateProtocol
//------------------------------------------------------

extension LocateViewController:LocationUpdateProtocol{
    // MARK: - LocationUpdateProtocol
    func locationDidUpdateToLocation(location: CLLocation) {
        currentLocation = location
        print("Latitude : \(currentLocation.coordinate.latitude)")
        print("Longitude : \(currentLocation.coordinate.longitude)")
        region = MKCoordinateRegion(center: currentLocation.coordinate, span: kSpan)
        mapView.setRegion(region, animated: true)
    }
}

