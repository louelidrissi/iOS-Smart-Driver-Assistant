//
//  LocationData.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//
import Foundation
import CoreLocation

// CLLocation is a reference type (class) and not Sendable by default.
// wrap relevant immutable properties in a Sendable struct. 
struct LocationData: Sendable {
    let latitude: Double
    let longitude: Double
    let altitude: Double
    let speed: CLLocationSpeed
    let timestamp: Date
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(from location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.altitude = location.altitude
        self.speed = location.speed
        self.timestamp = location.timestamp
    }
}

