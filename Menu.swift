//
//  Menu.swift
//  ZebedeeScript
//
//  Created by Thomas Ridd on 2/5/16.
//  Copyright © 2016 Thomas Ridd. All rights reserved.
//



import Cocoa

class Menu: NSMenu {
    
    var settings:ZebedeeScriptSettings = ZebedeeScriptSettings()
    
    
    @IBAction func selectDownload(sender: AnyObject) {
        if let task = settings.transferTaskWithName("download") {
            presentNewWindowWithTask(task)
        }
    }
    @IBAction func selectUpload(sender: AnyObject) {
        if let task = settings.transferTaskWithName("upload") {
            presentNewWindowWithTask(task)
        }
    }
    @IBAction func selectBackup(sender: AnyObject) {
        if let task = settings.transferTaskWithName("backup") {
            presentNewWindowWithTask(task)
        }
    }
    @IBAction func selectRestore(sender: AnyObject) {
        if let task = settings.transferTaskWithName("restore") {
            presentNewWindowWithTask(task)
        }
    }
    

    
    
    func presentNewWindowWithTask(transferTask:TransferTask) {
        
        // Create new ViewController
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let databaseTask = storyboard.instantiateControllerWithIdentifier("DatabaseTask") as! DatabaseTransferViewController
        databaseTask.transferTask = transferTask
        
        // Present it in a new window
        let taskWindow = NSWindow(contentViewController: databaseTask)
        taskWindow.setFrame(CGRect(x: 0, y: 0, width: 600, height: 480), display: true)
        //taskWindow.contentView =   databaseTask.view
        taskWindow.opaque      =   false
        taskWindow.center();
        taskWindow.makeKeyAndOrderFront(self)
    }
}
