//
//  QueryPageViewController.swift
//  ZebedeeScript
//
//  Created by Thomas Ridd on 2/4/16.
//  Copyright © 2016 Thomas Ridd. All rights reserved.
//
//
//import Cocoa
//
//protocol QueryPageDelegate {
//    func queryPageDidCancel(queryPage:QueryPageViewController)
//    func queryPageDidUpdate(querypage:QueryPageViewController, query:Query)
//    
//}
//
//public class QueryPageViewController: NSViewController {
//    var delegate: QueryPageDelegate?
//    var query: Query = Query(root: "", filters: [])
//    
//    @IBAction func clickOkay(sender: AnyObject) {
//        
//        self.delegate?.queryPageDidUpdate(self, query: self.query)
//        
//        
//        
//        self.parentViewController?.dismissViewController(self);
//    }
//    @IBAction func clickCancel(sender: AnyObject) {
//        self.delegate?.queryPageDidCancel(self)
//        self.parentViewController?.dismissViewController(self);
//    }
//
//}
