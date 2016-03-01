//
//  detailViewController.swift
//  mapping
//
//  Created by Lifoma Salaam on 2/27/16.
//  Copyright © 2016 CesaSalaam. All rights reserved.
//

import UIKit
import MapKit
class detailViewController: UIViewController, UITableViewDelegate{
    
    
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var label: UILabel!
    
    var newitem = parseSecJson()
    
    let id = NSUserDefaults.standardUserDefaults().objectForKey("tappedAnnoID") as! String// retrieving the place id of the annotation that was tapped.
    
    override func viewDidLoad() {
        doSecondApiStuff()
    }
    
    func doSecondApiStuff(){
        // This function makes the second API call with the placeId of the annotation tapped.
        
        let GOOGLE_API_KEY = "AIzaSyAzw_u47I2qXPZvMVN-1cKD-tHuEHSRm8g"
        print(id)
        let baseURL = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(id)&key=\(GOOGLE_API_KEY)"
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: (NSURL(string: baseURL))!)
        

        let task = session.dataTaskWithRequest(request){ (data, response, error) -> Void in
            
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            do {
                print("in do")
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                if let items = json["result"] as? [String: AnyObject]{
                    print(items)
                    let placeItem = parseSecJson(dict: items)
                    self.newitem = placeItem
                    self.addressLabel.text = " \(self.newitem.address)"
                }
            }catch{
                print("error with serializing JSON: \(error)")
            }
        }
        task.resume()
    }
    
}
