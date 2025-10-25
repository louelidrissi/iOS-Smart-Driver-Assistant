//
//  LocationManager.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//


import Foundation
import SwiftData

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var speed: CLLocationSpeed = 0.0

    // initializes your CLLocationManager
    override init() {
           super.init()
           locationManager.delegate = self // receive location callbacks.
           locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation // for driving scenarios)
           locationManager.allowsBackgroundLocationUpdates = true // Enables background updates
           locationManager.requestAlwaysAuthorization() //updates in foreground and background
           locationManager.distanceFilter = 10.0 //reduce update frequency to save battery
           locationManager.startUpdatingLocation()
       }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.last else { return }// get the latest location
        // extract data below
        location = latestLocation
        speed = latestLocation.speed // meters per second
        let latitude = latestLocation.coordinate.latitude
        let longitude = latestLocation.coordinate.longitude
        let timestamp = latestLocation.timestamp
        
        
        // call the async fetch for weather data
        Task {
             do {
                 let weather = try await fetchWeather(latitude: latitude, longitude: longitude, apiKey: Secrets.apiKey)
                 if let currentWeather = weather.weather.first {
                     let condition = currentWeather.main
                     print("Weather condition: \(currentWeather.main)")
                     // Update UI or model accordingly on main thread if needed
                 }
             } catch {
                 print("Failed to fetch or parse weather: \(error)")
             }
         }
        //stopUpdatingLocation & locationManagerDidChangeAuthorization(_:)
        
        // update your LLaMA model here
        
        // fetch weather data
        
       
        
        

    }
}
 
