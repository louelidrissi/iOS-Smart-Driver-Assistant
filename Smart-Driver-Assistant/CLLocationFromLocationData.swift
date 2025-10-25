//
//  CLLocationFromLocationData.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//
import CoreLocation

// Assuming you have LocationData struct with latitude, longitude, altitude, timestamp, etc.
extension CLLocation {
    convenience init(from locationData: LocationData) {
        self.init(latitude: locationData.latitude, longitude: locationData.longitude)
    }
}
