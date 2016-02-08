//
//  Settings.swift
//  ZebedeeScript
//
//  Created by Thomas Ridd on 2/6/16.
//  Copyright © 2016 Thomas Ridd. All rights reserved.
//

import Foundation
import SwiftyJSON

class ZebedeeScriptSettings {
    
    var settingsDictionary = [String:AnyObject]()
    var loaded = false
    
    func transferTaskWithName(name:String) -> TransferTask? {
        if let transfers = self.settingsDictionary["transfers"] as? [String: AnyObject] {
            if let transfer = transfers[name] as? [String: AnyObject] {
                if let origin = transfer["origin"] as? String, let destination = transfer["destination"] as? String {
                    if let subfolder = transfer["subfolder"] as? String {
                        return TransferTask(origin: origin, destination: destination, subfolder: subfolder, flags: [])
                    }
                    return TransferTask(origin: origin, destination: destination, subfolder: "", flags: [])
                }
            }
        }
        return nil
    }
    
    func defaultDatabase() -> String? {
        if let defaults = self.settingsDictionary["defaults"] as? [String: AnyObject] {
            if let db = defaults["database"] as? String {
                return db
            }
        }
        return nil
    }
    
    func defaultHost() -> String? {
        if let defaults = self.settingsDictionary["defaults"] as? [String: AnyObject] {
            if let host = defaults["host"] as? String {
                return host
            }
        }
        return nil
    }
    
    func defaultQuery() -> [String] {
        if let defaults = self.settingsDictionary["defaults"] as? [String: AnyObject] {
            if let query = defaults["query"] as? [String] {
                return query
            }
        }
        return []
    }
    
    init() {
        do {
            try loadSettingsFile()
        } catch _ {
            
        }
    }
    
    /**
     Check ~/Documents/ZebedeeScript exists and has a subdirectory
     
     - parameter subdirectory: the name of the subdirectory
     
     - throws: issues with fileManager
     */
    func checkDirectory(subdirectory:String) throws {
        let path = zebedeeScriptFilePath(subdirectory)
        let fileManager = NSFileManager.defaultManager()
        try fileManager.createDirectoryAtPath(path, withIntermediateDirectories: true, attributes: nil)
    }
    
    /**
     Return ~/Documents/ZebedeeScript/[file]
     
     - parameter file: any file or folder extension
     
     - returns: the full path to the file as a string
     */
    func zebedeeScriptFilePath(file:String) -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let path = NSURL(fileURLWithPath: documentDirectory).URLByAppendingPathComponent("ZebedeeScript").URLByAppendingPathComponent(file).path!
        return path;
    }
    
    func loadSettingsFile () throws {
        
        // Make sure settings files exist and if not create them
        try initialiseSettings()
        
        // Load json data
        let path = zebedeeScriptFilePath("Settings/Settings.json")
        let jsonData = try NSData(contentsOfFile:path, options: [])
        let jsonResults = JSON(data: jsonData)
        self.settingsDictionary = jsonResults.dictionaryObject!
        
    }
    
    func initialiseSettings() throws {
        
        try checkDirectory("Settings")
        let path = zebedeeScriptFilePath("Settings/Settings.json")
        
        let fileManager = NSFileManager.defaultManager()
        
        //check if file exists
        if(!fileManager.fileExistsAtPath(path)) {
            let bundlePath = NSBundle.mainBundle().pathForResource("Settings", ofType: "json")!
            try fileManager.copyItemAtPath(bundlePath, toPath: path)
        }
    }
}