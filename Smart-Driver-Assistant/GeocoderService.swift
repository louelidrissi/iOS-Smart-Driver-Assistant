//
//  GeocoderService.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//

// Get human readable location

import CoreLocation

//  geocoding is asynchronous and requires internet connection.
let geocoder = CLGeocoder()

func getAddress(from location: CLLocation, completion: @escaping (CLPlacemark?) -> Void) {
    geocoder.reverseGeocodeLocation(location) { placemarks, error in
        if let error = error {
            print("Reverse geocoding failed: \(error.localizedDescription)")
            completion(nil)
            return
        }
        guard let placemark = placemarks?.first else {
            completion(nil)
            return
        }
        completion(placemark)
    }
}
