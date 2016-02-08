////
////  Api.swift
////  ZebedeeScript
////
////  Created by Thomas Ridd on 2/2/16.
////  Copyright © 2016 Thomas Ridd. All rights reserved.
////
//
import Foundation
import SwiftyJSON

public class Api {
    public class func postCommands(commands: [String], lineProcessHandler:([String])->Void) {
        let urlPath: String = "http://localhost:8085/command"
        let url: NSURL = NSURL(string: urlPath)!
        let request1 = NSMutableURLRequest(URL: url)
        request1.HTTPMethod = "POST"

        do {
            request1.HTTPBody = try JSON(commands).rawData()
            
            let queue:NSOperationQueue = NSOperationQueue()
            
            NSURLConnection.sendAsynchronousRequest(request1, queue: queue, completionHandler: { (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                if let dataValue = data {
                    let responseJson = JSON(data:dataValue)
                    if let response = responseJson.arrayObject as? [String] {
                        lineProcessHandler(response)
                    }
                }
            })
        } catch {
            
        }
    }
}