//
//  MapItem.swift
//  Map With Direction
//
//  Created by Mac on 9/27/17.
//  Copyright © 2017 AtulPrakash. All rights reserved.
//

import Foundation
import MapKit

func mapItem(name title:String, location : CLLocation) -> MKMapItem {
    let placemark = MKPlacemark(coordinate: location.coordinate, addressDictionary: nil)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = title
    return mapItem
}
