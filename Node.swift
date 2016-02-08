//
//  Node.swift
//  ZebedeeScript
//
//  Created by Thomas Ridd on 1/31/16.
//  Copyright © 2016 Thomas Ridd. All rights reserved.
//

import Foundation
import SwiftyJSON

public class Node {
    var uri: String = ""
    var children: Array<Node> = []
    var filename: String = ""
    
    init(uri: String) {
        self.uri = uri;
    }
    
    init(json: JSON) {
        self.uri = json["uri"].stringValue
        self.filename = json["filename"].stringValue
        
        let childNodes = json["children"].array
        for nodeJson: JSON in childNodes! {
            self.children.append(Node(json: nodeJson))
        }
    }
    
    convenience init(data: NSData) {
        let json = JSON(data: data)
        self.init(json: json)
    }
    
    public func addChild(node: Node) -> Node {
        self.children.append(node)
        return self
    }
    
    public func asDict() -> Dictionary<String, AnyObject> {

        var childDicts = []
        for child:Node in children {
            childDicts = childDicts.arrayByAddingObject(child.asDict())
        }
        
        return ["uri":uri, "filename":filename, "children":childDicts]
    }
    
    public func asJson() -> JSON {
        return JSON(self.asDict())
    }
    
}
