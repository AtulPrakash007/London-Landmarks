//
//  NSDictionary+JSON.swift
//  Map With Direction
//
//  Created by Mac on 9/25/17.
//  Copyright © 2017 AtulPrakash. All rights reserved.
//

import Foundation

extension Dictionary{
    static func parseLocalJSONfrom(fileName name:String, fileExtension dotExtension:String) -> Dictionary<String, Any> {
        var resultDictionary = Dictionary<String, Any>()
        let filePath = Bundle.main.path(forResource: name, ofType: dotExtension)
        
        if let filePath = filePath {
            do {
                let fileUrl = URL(fileURLWithPath: filePath)
                let jsonData = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
                    let jsonDictionary =  json as! Dictionary<String,Any>
                    resultDictionary = jsonDictionary
//                    print(jsonDictionary)
                } catch {
                    print(error)
                }
                //                print(resultDictionary)
            } catch {
                print(error)
                fatalError("Unable to read contents of the file url")
            }
        }
        
        return resultDictionary
    }
}
