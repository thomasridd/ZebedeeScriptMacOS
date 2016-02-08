//
//  Result.swift
//  ZebedeeScript
//
//  Created by Thomas Ridd on 2/2/16.
//  Copyright © 2016 Thomas Ridd. All rights reserved.
//

import Foundation
import SwiftyJSON

public class ZebedeeResponse {
    var console: [String] = []
    
    init(json:JSON) {
        console.appendContentsOf(json["console"].arrayValue.map({p in p.stringValue}))
    }
    
    public func asDict() -> [String: AnyObject] {
        return ["console": self.console];
    }
}