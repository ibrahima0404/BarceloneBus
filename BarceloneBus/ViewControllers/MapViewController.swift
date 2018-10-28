//
//  MapViewController.swift
//  BarceloneBus
//
//  Created by Ibrahima KH GUEYE on 16/01/2018.
//  Copyright © 2018 Ibrahima KH GUEYE. All rights reserved.
//

/**
 * This VC contain a mapView on which all bus station is marked with a pin
 * by using the location coordinates
 */

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
let locationManager = CLLocationManager()
    @IBOutlet weak var mkMapView: MKMapView!
    var pin: PinAnnotation!
    var stationArray = [PinAnnotation]()
    let reqApi = RequestDataFromAPI()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mkMapView.delegate = self
        self.mkMapView.mapType = .standard
        reqApi.getJsonAPI { (jsonApi) in
            if jsonApi == nil {
                print("Error getJsonAPI")
            }
            let jsonData = jsonApi?.data.nearstations
            for station in jsonData! {
                let newItem1 = PinAnnotation(title: station.street_name, subTitle: "", lat: station.lat, lon: station.lon)
                self.stationArray.append(newItem1)
            }
            DispatchQueue.main.async {
                //self.mkMapView.reloadInputViews()
                self.mkMapView.addAnnotations(self.stationArray)
                self.mkMapView.setCenter(self.stationArray[0].coordinate, animated: true)
                let region = MKCoordinateRegionMakeWithDistance(self.stationArray[0].coordinate, 1000, 1000)
                self.mkMapView.setRegion(region, animated: true)
            }
        }
    }


    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Error: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        let location = locations.last
//        let coordinate = location?.coordinate
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate!
//        annotation.title = "Current Location"
//        mkMapView.addAnnotation(annotation)

        
    }
    
}
