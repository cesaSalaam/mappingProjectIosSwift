//
//  jsonParsingClass.swift
//  mapping
//
//  Created by Lifoma Salaam on 2/25/16.
//  Copyright © 2016 CesaSalaam. All rights reserved.
//

import UIKit

class parseJson {
    // this class parses through the first set of results from the first api call
    var name = String()
    var locationCoords = [Double]()
    var vicinity = String()
    var placeID = String()
    
    init(dict: [String: AnyObject]){
        setCoords(dict["geometry"] as! [String: AnyObject])
        self.vicinity = dict["vicinity"] as! String!
        self.name = dict["name"] as! String!
        self.placeID = dict["place_id"] as! String!
    }
    
    func setCoords(data: [String:AnyObject]) -> [Double]{
        //parses through the json to get the coordinates for the annotation
        let c = data["location"]
        locationCoords = [c!["lat"] as! Double, c!["lng"] as! Double]
        return locationCoords
    }
}

class parseSecJson{
    
    // this class parses through the first set of results from the second api call
    var address = String()
    var name = String()
    var hoursOfOpp = String()
    var icon = String()
    var rating = String()
    var height = String()
    var photoReference = String()

    init(dict: [String: AnyObject]){
        self.address = dict["vicinity"] as! String!
        self.name = dict["name"] as! String!
        self.icon = dict["icon"] as! String!
        //getPhoto(dict["photos"] as! [String: AnyObject])
        // print(photoReference)
        //print(height)
    }
    
    init(){}
    
    func getPhoto(photos: [String: AnyObject]){
            self.height = photos["height"] as! String
            self.photoReference = photos["photo_reference"] as! String
        // create function that makes API Call
    }
    
}


