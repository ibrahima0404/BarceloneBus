//
//  BusStations.swift
//  BeceloneBus
//
//  Created by Ibrahima KH GUEYE on 09/01/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import Foundation
import CoreLocation

struct BusStations {
    var stationId: Int!
    var name: String!
    var city: String!
    var bus: String!
    var utmX: String!
    var utmY: String!
    var lat: Double!
    var lon: Double!
    var fourniture: String!
    var distance: Double!
    var coordinate: CLLocationCoordinate2D!
    
    init(name: String, city: String, bus: String, coordinate: CLLocationCoordinate2D) {
        self.name = name
        self.city = city
        self.bus = bus
        self.coordinate = coordinate
    }
    
    init(dictionary: Dictionary<String, Any>) {
        self.stationId = Int(dictionary["id"] as! String)
        self.name = dictionary["street_name"] as? String
        self.city = dictionary["city"] as? String
        self.bus = dictionary["buses"] as? String
        self.utmX = dictionary["utm_x"] as? String
        self.utmY = dictionary["utm_y"] as? String
        self.lat = Double(dictionary["lat"] as! String)
        self.lon = Double(dictionary["lon"] as! String)
        self.fourniture = dictionary["furniture"] as? String
        self.distance = Double(dictionary["distance"] as! String)
        self.coordinate = CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
    }
    
    
}
