//
//  WeatherModels.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//

// Define Codable structs for JSON response.

struct WeatherAPIResponse: Codable {
    struct Weather: Codable {
        let id: Int
        let main: String    // e.g., "Rain", "Clear", "Fog"
        let description: String
    }
    let weather: [Weather]
}
