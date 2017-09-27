//
//  LondonLandmarks.swift
//  Map With Direction
//
//  Created by Mac on 9/22/17.
//  Copyright © 2017 AtulPrakash. All rights reserved.
//

import Foundation
import UIKit


class LondonLandmark: NSObject{
    
    //MARK: Properties
    
    var name: String
    var photo: String
    var postalCode: String
    var detail: String
    // While passing to CLLocation convert into float value
    var latitude:String
    var longitude = String()
    
    
    //MARK: Initialization
    
    init?(name: String, photo: String, postalCode: String, detail:String, latitude:String, longitude:String) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        guard !postalCode.isEmpty else {
            return nil
        }

        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.postalCode = postalCode
        self.detail = detail
        self.latitude = latitude
        self.longitude = longitude
        
    }
}
