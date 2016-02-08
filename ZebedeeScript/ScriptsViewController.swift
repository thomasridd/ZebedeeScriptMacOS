//
//  ScriptsViewController.swift
//  ZebedeeScript
//
//  Created by Thomas Ridd on 2/7/16.
//  Copyright © 2016 Thomas Ridd. All rights reserved.
//

import Cocoa

class ScriptsViewController: NSViewController {
    var scriptList: ScriptList!
    
    @IBOutlet weak var scriptName: NSTextField!
    @IBOutlet var scriptContent: NSTextView!
    @IBOutlet weak var scriptsTable: NSTableView!
    
    @IBAction func newScript(sender: AnyObject) {
        self.scriptList.addScript()
        self.scriptsTable.reloadData()
    }
    @IBAction func refreshScripts(sender: AnyObject) {
        scriptList.refreshList()
        self.scriptsTable.reloadData()
    }
    @IBAction func renameScripts(sender: AnyObject) {
        
    }
    @IBAction func deleteScript(sender: AnyObject) {
        self.currentScript()?.delete()
        self.scriptsTable.reloadData()
    }
    @IBAction func saveScript(sender: AnyObject) {
        let content:[String] = (self.scriptContent.string?.componentsSeparatedByString("\n"))!
        self.currentScript()?.content = content
        self.currentScript()?.writeContent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        scriptList = ScriptList()
    }
    override func viewDidAppear() {
        self.scriptContent.font = NSFont(name: "Menlo", size: 12)
        self.scriptContent.textStorage!.font = NSFont(name: "Menlo", size: 12)
    }
    
    @IBAction func runScript(sender: AnyObject) {
        let commands:[String] = (self.scriptContent.string?.componentsSeparatedByString("\n"))!
        Api.postCommands(commands) { (responses) -> Void in
            for response in responses {
                print(response)
            }
        }
    }
    
    
    func currentScript() -> Script? {
        let row = self.scriptsTable.selectedRow
        if  row >= 0 {
            return self.scriptList.scripts[row]
        }
        return nil
    }
    
}

extension ScriptsViewController : NSTableViewDataSource {
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return self.scriptList.scripts.count
    }
    func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        let item = self.scriptList.scripts[row]
        item.readContent()
        self.scriptContent.string = item.content.joinWithSeparator("\n")
        
        return true
    }
}

extension ScriptsViewController : NSTableViewDelegate {
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        var text:String = ""
        var cellIdentifier: String = ""
        
        // 1
        let item = self.scriptList.scripts[row]
        
        // 2
        if tableColumn == tableView.tableColumns[0] {
            text = item.file.substringToIndex(item.file.characters.endIndex.advancedBy(-7))
            cellIdentifier = "ScriptCellId"
        }
        
        // 3
        if let cell = tableView.makeViewWithIdentifier(cellIdentifier, owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        return nil
    }
}