//
//  Dictionary.swift
//  CookieCrunch
//
//  Created by Renato Camilio on 2/22/15.
//  Copyright (c) 2015 Renato Camilio. All rights reserved.
//

import Foundation

extension Dictionary {

    static func loadJSONFromBundle(fileName: String) -> Dictionary<String, AnyObject>? {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        
        if let validPath = path {
            var error: NSError?
            
            let data: NSData? = NSData(contentsOfFile: validPath, options: NSDataReadingOptions(), error: &error)
            
            if let validData = data {
                let dictionary: AnyObject? = NSJSONSerialization.JSONObjectWithData(validData, options: NSJSONReadingOptions(), error: &error)
                
                if let validDictionary = dictionary as? Dictionary<String, AnyObject> {
                    return validDictionary
                } else {
                    println("Level file '\(fileName)' is not valid JSON: \(error!)")
                    return nil
                }
            } else {
                println("Could not load level file: \(fileName), error: \(error!)")
                return nil
            }
        } else {
            println("Could not find level file: \(fileName)")
            return nil
        }
    }
    
}
