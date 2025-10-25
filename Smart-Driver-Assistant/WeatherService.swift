//
//  WeatherService.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//

// fetch weather data asynchronously

import Foundation
import CoreLocation


func fetchWeather(latitude: Double, longitude: Double, apiKey: String) async throws -> WeatherAPIResponse {
    let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
    guard let url = URL(string: urlString) else {
        throw URLError(.badURL)
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let httpResponse = response as? HTTPURLResponse,
          (200...299).contains(httpResponse.statusCode) else {
        throw URLError(.badServerResponse)
    }
    // json parsing
    let weatherResponse = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
    return weatherResponse
}
