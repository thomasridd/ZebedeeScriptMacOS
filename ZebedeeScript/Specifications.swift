////
////  Specifications.swift
////  ZebedeeScript
////
////  Created by Thomas Ridd on 2/2/16.
////  Copyright © 2016 Thomas Ridd. All rights reserved.
////
//
//import Foundation
//
//public class ActionSpecification {
//    var family:String
//    var verb: String
//    var parameters: [String] = []
//    
//    init(family:String, verb:String, parameters:[String]) {
//        self.family = family
//        self.verb = verb
//        self.parameters = parameters
//    }
//    
//    public class func all() -> [ActionSpecification] {
//        var allSpecs: [ActionSpecification] = []
//        
//        allSpecs.append(ActionSpecification(family: "info", verb: "list", parameters: []))
//        allSpecs.append(ActionSpecification(family: "info", verb: "table", parameters: ["fields"]))
//        
//        allSpecs.append(ActionSpecification(family: "json", verb: "put", parameters: ["root", "field", "value"]))
//        allSpecs.append(ActionSpecification(family: "json", verb: "add", parameters: ["root", "field", "value"]))
//        
//        allSpecs.append(ActionSpecification(family: "files", verb: "copy", parameters: ["root"]))
//        allSpecs.append(ActionSpecification(family: "files", verb: "copy", parameters: ["root", "uri"]))
//        allSpecs.append(ActionSpecification(family: "files", verb: "move", parameters: ["uri"]))
//        allSpecs.append(ActionSpecification(family: "files", verb: "delete", parameters: []))
//        allSpecs.append(ActionSpecification(family: "files", verb: "replace", parameters: ["old", "new"]))
//        
//
//        return allSpecs
//    }
//}
//
//public class QuerySpecification {
//    var family:String
//    var member: String
//    var parameters: [String] = []
//    
//    init(family:String, member:String, parameters:[String]) {
//        self.family = family
//        self.member = member
//        self.parameters = parameters
//    }
//    
//    public class func all() -> [QuerySpecification] {
//        var allSpecs: [QuerySpecification] = []
//        
//        allSpecs.append(QuerySpecification(family: "uri", member: "starts", parameters: ["value"]))
//        allSpecs.append(QuerySpecification(family: "uri", member: "ends", parameters: ["value"]))
//        allSpecs.append(QuerySpecification(family: "uri", member: "contains", parameters: ["value"]))
//        
//        allSpecs.append(QuerySpecification(family: "uri", member: "type", parameters: ["value"]))
//        
//        allSpecs.append(QuerySpecification(family: "json", member: "valid", parameters: []))
//        allSpecs.append(QuerySpecification(family: "json", member: "has", parameters: ["path"]))
//        allSpecs.append(QuerySpecification(family: "json", member: "equals", parameters: ["path", "value"]))
//        allSpecs.append(QuerySpecification(family: "json", member: "populated", parameters: ["arraypath"]))
//        allSpecs.append(QuerySpecification(family: "json", member: "contains", parameters: ["arraypath", "value"]))
//        
//        allSpecs.append(QuerySpecification(family: "xls", member: "valid", parameters: []))
//        
//        allSpecs.append(QuerySpecification(family: "text", member: "contains", parameters: ["value"]))
//        
//        return allSpecs
//    }
//}
//
//
