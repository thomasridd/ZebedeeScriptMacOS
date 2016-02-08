//
//import Cocoa
//import SwiftyJSON
//
//class FileQueryController: NSViewController {
//    
//    @IBAction func clickApply(sender: AnyObject) {
//        postFile()
//    }
//    
//    func postFile() {
//        let filter = Filter(family: "uri", member: "starts", parameters: ["value": "hello"])
//        let query = Query(root: "/Users/thomasridd/ons/content/zebedee/master", filters: [filter])
//        let action = Action(family: "info", verb: "list", parameters: [String: String]())
//        let command = Command(query: query, action: action)
//        Api.postCommand(command) { (response) -> Void in
//            print(JSON(response.asDict()).rawString())
//        }
//    }
//    
//    
//    func parseJSON(inputData: NSData) -> NSDictionary{
//        
//        var dict = NSDictionary();
//        do {
//            dict = try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
//        } catch _ {
//            
//        }
//        
//        return dict
//    }
//}
