//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by William Eze on 12/03/2024.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnowLocation: String = ""
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorisation(){
        manager.requestWhenInUseAuthorization()
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let firstlocation = locations.first {
            geocoder.reverseGeocodeLocation(firstlocation, completionHandler: { placemarks, error in
                if error != nil {
                    self.lastKnowLocation = "Could not perofrm lookup of location from coordinate information"
                }
                else{
                    if let firstPlacemark = placemarks?[0] {
                        self.lastKnowLocation = """
\(firstPlacemark.subThoroughfare ?? "") \(firstPlacemark.thoroughfare ?? "")
\(firstPlacemark.subLocality ?? "")
\(firstPlacemark.postalCode ?? "")
\(firstPlacemark.locality ?? "")
\(firstPlacemark.country ?? "")
"""
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.lastKnowLocation = "Error finding locaiton"
    }
    
}
