//
//  ViewController.swift
//  Map With Direction
//
//  Created by Mac on 9/22/17.
//  Copyright © 2017 AtulPrakash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var londonLandmarks = [LondonLandmark]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLondonLandmark(from: "LondonLandmarks", fExtension: "json")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Wrong need to change
    func loadLondonLandmark(from fName:String, fExtension:String) {
        let parseDict = Dictionary<String, Any>.parseLocalJSONfrom(fileName: fName, fileExtension:fExtension)
        
        if parseDict.isEmpty{
            print("Error in Parsing Local File, return empty Dictionary")
        }else{
//            print(parseDict)
            let landmarkArr = parseDict["Landmarks"] as! Array<Dictionary<String,Any>>
            //        print(landmarkArr)
            for landmark in landmarkArr{
                let name = landmark["name"] as! String
                let photo = landmark["photo"] as! String
                let postalCode = landmark["postalCode"] as! String
                let detail = landmark["detail"] as! String
                let latitude = landmark["latitude"] as! String 
                let longitude = landmark["longitude"] as! String
                
                guard let sampleLandmark = LondonLandmark(name: name, photo: photo, postalCode:postalCode, detail: detail, latitude: latitude, longitude: longitude) else
                {
                    fatalError("Unable to instantiate sampleLandmark")
                }
                londonLandmarks.append(sampleLandmark)
            }
        }
    }
    
    @IBAction func moveToLondon(_ sender: Any) {
        print(londonLandmarks)
        self.performSegue(withIdentifier: "goToListView", sender: self)
    }
    
    @IBAction func moveToLocate(_ sender: Any) {
        self.performSegue(withIdentifier: "goToLocate", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "goToListView":
            let destinationVC = segue.destination as! TableViewController
            destinationVC.londonLandmarks = londonLandmarks
            
        case "goToLocate":
            print("Locate Me")
            
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

}

