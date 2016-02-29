//
//  jsonParsingClass.swift
//  mapping
//
//  Created by Lifoma Salaam on 2/25/16.
//  Copyright © 2016 CesaSalaam. All rights reserved.
//

import UIKit

class parseJson {
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

class parseSecJason{
    var address = String()
    var name = String()
    var hoursOfOpp = String()
    var icon = String()


}
