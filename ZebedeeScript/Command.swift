////
////  Command.swift
////  ZebedeeScript
////
////  Created by Thomas Ridd on 2/1/16.
////  Copyright © 2016 Thomas Ridd. All rights reserved.
////
//
//import Foundation
//import SwiftyJSON
//
//public class Script {
//    var commands: Array<Command> = []
//    
//    init() {
//        
//    }
//    
//    init(json:JSON) {
//        for commandJson in json["commands"].arrayValue {
//            commands.append(Command(json: commandJson))
//        }
//    }
//    public func asDict() -> [String: AnyObject] {
//        return ["commands": commands.map({c in c.asDict()})]
//    }
//}
//
//public class Command {
//    var query: Query?
//    var uri: String?
//    var action: Action
//    
//    public init(query:Query, action:Action) {
//        self.query = query
//        self.action = action
//    }
//    
//    public init(uri:String, action:Action) {
//        self.action = action
//        self.uri = uri
//    }
//    
//    public required init(json:JSON) {
//        self.action = Action(json: json["action"])
//        if json["query"].isExists() { self.query = Query(json: json["query"]) }
//        if json["uri"].isExists() { self.uri = json["uri"].stringValue }
//    }
//    
//    public func asDict() -> [String: AnyObject] {
//        if let query = self.query {
//            return ["query": query.asDict(), "action": self.action.asDict()]
//        } else {
//            return ["uri": self.uri!, "action": self.action.asDict()]
//        }
//    }
//}
//
//public class Action {
//    var family: String = "list"
//    var verb: String = ""
//    var parameters: [String: String] = [String: String]()
//    
//    init(family: String, verb: String, parameters: [String: String]) {
//        self.family = family
//        self.verb = verb
//        self.parameters = parameters
//    }
//    
//    init(json:JSON) {
//        self.family = json["family"].stringValue
//        self.verb = json["verb"].stringValue
//        
//        let parameterJson = json["parameters"]
//        for (key,subJson):(String, JSON) in parameterJson {
//            self.parameters[key] = subJson.stringValue
//        }
//    }
//    
//    public func asDict() -> [String: AnyObject] {
//        return ["family": family, "verb": verb, "parameters": parameters]
//    }
//}
//
//public class Query {
//    var root: String = ""
//    var filters: Array<Filter> = []
//    
//    init(root: String, filters: [Filter]) {
//        self.root = root
//        self.filters = filters
//    }
//    
//    init(json: JSON) {
//        self.root = json["root"].stringValue
//        for filterJson:JSON in json["filters"].arrayValue {
//            filters.append(Filter(json: filterJson))
//        }
//    }
//    
//    public func asDict() -> Dictionary<String, AnyObject> {
//        let filterList = self.filters.map {
//            (f: Filter) -> [String: AnyObject] in return f.asDict()
//        };
//        
//        return ["root":root, "filters":filterList]
//    }
//}
//
//public class Filter {
//    var family: String = ""
//    var member: String = ""
//    var parameters: [String:String] = [String: String]()
//    
//    init(family: String, member: String, parameters: [String:String]) {
//        self.family = family
//        self.member = member
//        self.parameters = parameters
//    }
//    
//    init(json: JSON) {
//        self.family = json["family"].stringValue
//        self.member = json["member"].stringValue
//        
//        let parameterJson = json["parameters"]
//        for (key,subJson):(String, JSON) in parameterJson {
//            self.parameters[key] = subJson.stringValue
//        }
//    }
//    
//    public func asDict() -> [String: AnyObject] {
//        return ["family": family, "member": member, "parameters": parameters]
//    }
//}
//
