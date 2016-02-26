//
//  ViewController.swift
//  mapping
//
//  Created by Lifoma Salaam on 2/25/16.
//  Copyright © 2016 CesaSalaam. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate{

    var placesArray:[place] = []
    
    var typeKey = String() // variable for the type the user searches for
    
    var placeKey = String() // variable for what the name of the place the user searches for
    
    let locationManager = CLLocationManager()
    
    var lng = Double() // variable to hold the longitude
    
    var lat = Double() // variable to holf the latitude
    
    @IBOutlet var map: MKMapView!
    
    @IBOutlet weak var placeTextfield: UITextField!
    
    @IBAction func submit(sender: AnyObject) {
        
        //action for when the submit button is clicked
        // this function runs checks if valid input is in the text fields and then runs the search
        
        let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
        
        let tempInput = placeTextfield.text
        
        if tempInput!.stringByTrimmingCharactersInSet(whitespaceSet) == "" {
            // this statement stops user from searching for something thats empty
            return
        }
        if var _ = placeTextfield.text?.characters.last{
            
            self.placeKey = placeTextfield.text!.stringByReplacingOccurrencesOfString(" ", withString: "_")
        }
        doApiStuff()
    }

    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // this function gets the users location and makes the make zoom into their location
        // this function creates an array of locations and uses the last one for the location of the user
        
        let location = locations.last
        
        lng = location!.coordinate.longitude
        
        lat = location!.coordinate.latitude
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        self.map.setRegion(region, animated: true)
        
        self.locationManager.stopUpdatingLocation() // stops getting locations
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        // prints an error is the location cant be gotten
        print("error: \(error.localizedDescription)")
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //resigns keyboard when user tapps the return key.
        placeTextfield.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //resigns the key boards when the user touches the screen
        placeTextfield.resignFirstResponder()
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization() // asks users for permission to use their location
        
        self.locationManager.startUpdatingLocation() //gets location
        
        self.map.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: MKMapViewDelegate{

    func doApiStuff(){
        //This function makes the requests to the google places api
        //This function addds the annotations the map.
        
        let center = CLLocationCoordinate2DMake(lat, lng)
        
        let region = MKCoordinateRegionMake(center, MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        
        let GOOGLE_API_KEY = "AIzaSyAzw_u47I2qXPZvMVN-1cKD-tHuEHSRm8g"
        
        let baseURL = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(lat),\(lng)&radius=500&type=\(placeKey)&name=&key=\(GOOGLE_API_KEY)"
        
        let session = NSURLSession.sharedSession()
        
        let request = NSMutableURLRequest(URL: NSURL(string: baseURL)!)
        
        let task = session.dataTaskWithRequest(request){ (data, response, error) -> Void in
            
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                
                if let items = json["results"] as? [[String: AnyObject]]{
                    var arrayOfParsingTools = [parseJson]()
                    for item in items{
                        let parsingTool = parseJson(dict: item)
                        arrayOfParsingTools.append(parsingTool)
                    }
                    
                    for parsedItem in arrayOfParsingTools{
                        let newPlace = place(coordinate: parsedItem.locationCoords, name: parsedItem.name, vicinity: parsedItem.vicinity, placeID: parsedItem.placeID)
                        self.placesArray.append(newPlace)
                        
                    }
                    self.map.addAnnotations(self.placesArray)
                    dispatch_async(dispatch_get_main_queue()){
                        self.map.setRegion(region, animated: true)
                    }
                }
            }catch{
                print("error with serializing JSON: \(error)")
            }
        }
        task.resume()
    }

}




















