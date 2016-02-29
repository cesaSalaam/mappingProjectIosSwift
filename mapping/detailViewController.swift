//
//  detailViewController.swift
//  mapping
//
//  Created by Lifoma Salaam on 2/27/16.
//  Copyright © 2016 CesaSalaam. All rights reserved.
//

import UIKit
import MapKit
class detailViewController: UIViewController{
    
    
    @IBOutlet var label: UILabel!
    let id = NSUserDefaults.standardUserDefaults().objectForKey("tappedAnnoID") as! String
    
    override func viewDidLoad() {
        doSecondApiStuff()
    }
    
    func doSecondApiStuff(){
        //This function makes the requests to the google places api
        //This function addds the annotations the map.
    
        let GOOGLE_API_KEY = "AIzaSyAzw_u47I2qXPZvMVN-1cKD-tHuEHSRm8g"
        print(id)
        let baseURL = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(id)&key=\(GOOGLE_API_KEY)"
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: (NSURL(string: baseURL))!)//NSMutableURLRequest(URL: NSURL(string: baseURL)!)
        

        let task = session.dataTaskWithRequest(request){ (data, response, error) -> Void in
            
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            do {
                print("in do")
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                print(json)
                if let items = json["result"] as? [[String: AnyObject]]{
                    print(items)
                    var arrayOfParsingTools = [parseJson]()
                    for item in items{
                        let parsingTool = parseJson(dict: item)
                        arrayOfParsingTools.append(parsingTool)
                    }
                    // dispatch_async(dispatch_get_main_queue()){
                    //}
                }
            }catch{
                print("error with serializing JSON: \(error)")
            }
        }
        task.resume()
    }
}
