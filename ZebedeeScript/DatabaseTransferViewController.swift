//
//  DatabaseTransferViewController.swift
//  ZebedeeScript
//
//  Created by Thomas Ridd on 2/5/16.
//  Copyright © 2016 Thomas Ridd. All rights reserved.
//

import Cocoa

class DatabaseTransferViewController: NSViewController {
    var outputPipe: NSPipe = NSPipe()
    
    @IBOutlet weak var originText: NSTextField!
    @IBOutlet weak var destinationText: NSTextField!
    @IBOutlet weak var subfolderText: NSTextField!
    var transferTask: TransferTask?
    var runningTask: NSTask?
    
    @IBOutlet var console: NSTextView!
    
    func initWithTransferTask(transferTask:TransferTask) {
        self.transferTask = transferTask
        
        self.originText.stringValue = transferTask.origin
        self.destinationText.stringValue = transferTask.destination
        self.subfolderText.stringValue = transferTask.subfolder
    }
    
    override func viewDidLoad() {
        if let task = transferTask {
            initWithTransferTask(task)
        }
    }
    
    @IBAction func startTask(sender: AnyObject) {
        
        // Quick idiot check that we aren't about to copy over root
        if self.destinationText.stringValue.characters.count < 20 {
            print("Friends don't let friends wipe their hard drives")
            return
        }
        
        // Run the transfer
        runTransferTask(TransferTask(origin: self.originText.stringValue,
            destination: self.destinationText.stringValue,
            subfolder: self.subfolderText.stringValue, flags: []))
    }
    @IBAction func cancelTask(sender: AnyObject) {
        if let atask = self.runningTask {
            atask.terminate()
        }
    }
    
    
    func runTransferTask(task: TransferTask) {
      
        let taskQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
        dispatch_async(taskQueue) { () -> Void in
            //1
            //        NSTask *task = [[NSTask alloc] init];
            self.runningTask = task.asTask()
            
            //        //4
            //        [task launch];
            self.handleOutput(self.runningTask!)
            self.runningTask!.launch()
            //
            //        //5
            //        [task waitUntilExit];
            self.runningTask!.waitUntilExit()
            
            self.runningTask = nil
        }
        

    }
    
    
    func handleOutput (task:NSTask) {
        self.outputPipe = NSPipe()
        task.standardOutput = self.outputPipe
        
        self.outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.addObserverForName(NSFileHandleDataAvailableNotification, object: self.outputPipe.fileHandleForReading, queue: nil) { (notification) -> Void in
            let output = self.outputPipe.fileHandleForReading.availableData
            let outStr = String(data: output, encoding: NSUTF8StringEncoding)
            
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.console.string = self.console.string! + "\n" + outStr!
                
                let str = self.console.string!
                if str.characters.count > 5000 {
                    self.console.string =  str.substringWithRange(Range<String.Index>(start: str.endIndex.advancedBy(-5000), end: str.endIndex))
                }
                
                let range = NSMakeRange(self.console.string!.characters.count, 0)
                self.console.scrollRangeToVisible(range)
            })
            
            self.outputPipe.fileHandleForReading.waitForDataInBackgroundAndNotify()
        }
    }
}

struct TransferTask {
    var origin = ""
    var destination = ""
    var flags:[String] = [];
    var subfolder = ""
    
    init(origin:String, destination:String, subfolder:String, flags:[String]) {
        self.origin = origin
        self.destination = destination
        self.subfolder = subfolder
        self.flags = flags
    }
    
    func asTask() -> NSTask {
        let task = NSTask()
        task.launchPath = "/usr/bin/rsync"
        
        var parameters = [String]()
        parameters.append("-rvhe ssh")
        parameters.append("--delete")
        parameters.append("--progress")
        
        parameters.append(combinePath(self.origin, subpath: self.subfolder))
        parameters.append(combinePath(self.destination, subpath: self.subfolder))
        
        task.arguments = parameters
        return task
    }
    func combinePath(path:String, subpath:String) -> String {
        if subpath.characters.count == 0 {return path}
        
        if path.characters.last! == "/" {return path + subpath + "/" }
        
        return path + "/" + subpath +  "/"
    }
    

}
