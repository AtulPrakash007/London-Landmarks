//
//  DetailViewController.swift
//  Map With Direction
//
//  Created by Mac on 9/25/17.
//  Copyright © 2017 AtulPrakash. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class DetailViewController: UIViewController {
    
    //Outlets of Storyboard
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var landMarkImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var postalCodeLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    // Variable Declarations
    var londonLandmark: LondonLandmark?
    var name:String = ""
    var postalCode:String = ""
    var latitude = Double()
    var longitude = Double()
    
    
    //Map Variables
    var currentLocation : CLLocation!
    var locationManager = CLLocationManager()
    
    let annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.SharedManager.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
        if let londonLandmark = londonLandmark {
            name = londonLandmark.name
            landMarkImage.image = UIImage.init(named: londonLandmark.photo)
            postalCode = londonLandmark.postalCode
            detailLbl.text = londonLandmark.detail
            latitude = Double(londonLandmark.latitude)!
            longitude = Double(londonLandmark.longitude)!
        }
        
        headingLbl.text = name
        titleLbl.text = name
        postalCodeLbl.text = postalCode
        
        // map View initial setting
        mapView.delegate = self
        mapView.mapType = .standard
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Check location access
        let locationAuthorization = LocationAuthorization()
        if locationAuthorization.checkLocationAccess(){
            
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let landmarkLocation = CLLocation(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion.init(center: landmarkLocation.coordinate, span: kSpan)
        annotation.coordinate = landmarkLocation.coordinate
        annotation.title = name
        annotation.subtitle = postalCode
        mapView.addAnnotation(annotation)
        mapView.setRegion(region, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        LocationManager.SharedManager.stopUpdatingLocation()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openMapAction(_ sender: Any) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                             MKLaunchOptionsMapSpanKey:kSpan] as [String : Any]
        mapItem(name: name, location: location).openInMaps(launchOptions: launchOptions)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

//------------------------------------------------------
// MARK: - LocationUpdateProtocol
//------------------------------------------------------

extension DetailViewController:LocationUpdateProtocol{
    // MARK: - LocationUpdateProtocol
    func locationDidUpdateToLocation(location: CLLocation) {
        currentLocation = location
        print("Latitude : \(currentLocation.coordinate.latitude)")
        print("Longitude : \(currentLocation.coordinate.longitude)")
    }
}

//------------------------------------------------------
// MARK: - MKMapViewDelegate
//------------------------------------------------------

extension DetailViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView .setCenter(userLocation.coordinate, animated: true)
        annotation.coordinate = userLocation.coordinate
        mapView.addAnnotation(annotation)
    }
}
