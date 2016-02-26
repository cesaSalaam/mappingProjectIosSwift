//
//  placeClass.swift
//  mapping
//
//  Created by Lifoma Salaam on 2/25/16.
//  Copyright © 2016 CesaSalaam. All rights reserved.
//

import UIKit
import MapKit

class place: NSObject, MKAnnotation {
    //This class handles the json parsing and it creates the annotations for the map.
    var locationCoords = [Double]()
    var placeID = String()
    var title:String?
    var subtitle:String?
    var coordinate:CLLocationCoordinate2D
    
    init(coordinate: [Double], name: String, vicinity: String, placeID: String){
        
        self.coordinate = CLLocationCoordinate2DMake(coordinate[0], coordinate[1])
        self.subtitle = vicinity
        self.title = name
        self.placeID = placeID
        super.init()
    }
    
}