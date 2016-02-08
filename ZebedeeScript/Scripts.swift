//
//  Scripts.swift
//  ZebedeeScript
//
//  Created by Thomas Ridd on 2/7/16.
//  Copyright © 2016 Thomas Ridd. All rights reserved.
//

import Foundation

public class Script {
    var file:String = ""
    var path:String = ""
    var content: [String] = []
    
    init(path: String, file:String) {
        self.path = path
        self.file = file
    }
    
    func getFullPath() -> String {
        return self.path + "/" + self.file
    }
    
    func readContent() {
        do {
            let text = try String(contentsOfFile: self.getFullPath(), encoding: NSUTF8StringEncoding)
            self.content = text.componentsSeparatedByString("\n")
        } catch {
            print("could not read contents of file " + self.getFullPath())
        }
    }
    
    func writeContent() {
        let singleString = self.content.joinWithSeparator("\n")
        do {
            try singleString.writeToFile(self.getFullPath(), atomically: false, encoding: NSUTF8StringEncoding)
        } catch {
            print("could not write to path " + self.getFullPath())
        }
    }
    
    func delete() {
        let fileManager = NSFileManager.defaultManager()
        do {
            try fileManager.removeItemAtPath(self.getFullPath())
        } catch {
            print("could not delete at path " + self.getFullPath())
        }
    }
    
    func rename(newName: String) {
        let fileManager = NSFileManager.defaultManager()
        do {
            try fileManager.moveItemAtPath(self.getFullPath(), toPath: self.path + "/" + newName)
            self.file = newName
        } catch {
            print("could not rename at path " + self.getFullPath())
        }
    }
}

public class ScriptList {
    var root: String
    var scripts: [Script] = []
    
    init() {
        let settings = ZebedeeScriptSettings()
        self.root = settings.zebedeeScriptFilePath("Scripts/")
        
        do {
            try settings.checkDirectory("Scripts/")
            refreshList()
        } catch {
            print("error creating scripts directory")
        }
    }
    
    func refreshList() {
        let fileManager = NSFileManager.defaultManager()
        let enumerator:NSDirectoryEnumerator? = fileManager.enumeratorAtPath(self.root)
        
        self.scripts = []
        while let element = enumerator?.nextObject() as? String {
            if element.hasSuffix("script") { // checks the extension
                let script = Script(path: self.root, file: element)
                scripts.append(script)
            }
        }
        

    }
    
    func addScript(name:String, suffix:String) -> Script {
        let script = Script(path: self.root, file: uniqueName(self.root, name: name, suffix: suffix))
        script.content = ZebedeeScriptSettings().defaultQuery()
        script.writeContent()
        
        self.scripts.append(script)
        return script
    }
    
    func addScript() {
        addScript("ZebedeeScript", suffix: "script")
    }
    
    func uniqueName(path:String, name:String, suffix:String) -> String {
        if fileExists(path, name:  name, suffix: suffix) == false {
            return name + "." + suffix
        } else {
            var i:Int = 1
            while fileExists(path, name:  "\(name)\(i)", suffix: suffix) { i = i + 1 }
            return "\(name)\(i).\(suffix)"
        }
    }
    
    func fileExists(path:String, name:String, suffix:String) -> Bool {
        let fileManager = NSFileManager.defaultManager()
        return fileManager.fileExistsAtPath(path + "/" + name + "." + suffix)
    }
    
}