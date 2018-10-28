//
//  PinAnnotation.swift
//  BarceloneBus
//
//  Created by Ibrahima KH GUEYE on 16/01/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class PinAnnotation: NSObject, MKAnnotation{
    var title: String?
    var subTitle: String?
    var lat: String?
    var lon: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String, subTitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subTitle = subTitle
        self.coordinate = coordinate
    }
    
    init(title: String, subTitle: String, lat: String, lon: String) {
        self.title = title
        self.subTitle = subTitle
        let lat = Double(lat)!
        let lon = Double(lon)!
        self.coordinate = CLLocationCoordinate2D(latitude: lat , longitude: lon)
        
    }
}
