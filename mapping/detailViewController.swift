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
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var label: UILabel!
    
    var arrayOfSecJson = [parseSecJson]()
    var item = parseSecJson()
    
    let id = NSUserDefaults.standardUserDefaults().objectForKey("tappedAnnoID") as! String
    
    override func viewDidLoad() {
        doSecondApiStuff()
        tableView.reloadData()
    }
    
    func doSecondApiStuff(){
        //This function makes the requests to the google places api
        //This function addds the annotations the map.
        //self.arrayOfSecJson.removeAll()
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
                if let items = json["result"] as? [String: AnyObject]{
                    let placeItem = parseSecJson(dict: items)
                    self.item = placeItem
                }
            }catch{
                print("error with serializing JSON: \(error)")
            }
        }
        task.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.item.name
    return cell
    }
    
}
