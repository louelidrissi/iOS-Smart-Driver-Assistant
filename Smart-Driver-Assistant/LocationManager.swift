//
//  LocationManager.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//
import Foundation
import CoreLocation
import Combine
// used Combine's reactive programming features: for ObservableObject, @Published, and reactive stream management.

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var locationData: LocationData?
    @Published var speed: CLLocationSpeed = 0.0
    @Published var timestamp: Date = Date()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 10.0
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }
        let newLocationData = LocationData(from: latestLocation)

        DispatchQueue.main.async {
            self.locationData = newLocationData
            self.speed = latestLocation.speed
            self.timestamp = latestLocation.timestamp
        }
    }
}
