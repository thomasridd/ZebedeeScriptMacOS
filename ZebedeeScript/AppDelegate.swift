//
//  AppDelegate.swift
//  ZebedeeScript
//
//  Created by Thomas Ridd on 1/29/16.
//  Copyright © 2016 Thomas Ridd. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func launchDownload(sender: AnyObject) {

        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let databaseTask = storyboard.instantiateControllerWithIdentifier("DatabaseTask") as! DatabaseTransferViewController
         let window1 = NSWindow(contentViewController: databaseTask)

            window1.setFrame(CGRect(x: 0, y: 0, width: 600, height: 480), display: true)
            window1.contentView =   databaseTask.view
            window1.opaque      =   false
            window1.center();
            window1.makeKeyAndOrderFront(self)
    }
        
    }

    
    


