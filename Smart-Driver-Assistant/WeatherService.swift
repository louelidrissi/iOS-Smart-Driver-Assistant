//
//  WeatherService.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//

// fetch weather data asynchronously

import Foundation
import CoreLocation

final class WeatherService: ObservableObject, @unchecked Sendable {
    // make concurrency safe using Sendable to safely share data
    // This class cannot be subclassed. Final improves ~performance
    
    @Published var currentWeatherCondition: String = ""

    func fetchWeather(latitude: Double, longitude: Double, apiKey: String) async {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let weatherResponse = try JSONDecoder().decode(WeatherAPIResponse.self, from: data)
            
            DispatchQueue.main.async { [weak self] in //avoids strong capture and possible concurrency safety issues.
                if let condition = weatherResponse.weather.first?.main {
                    self?.currentWeatherCondition = condition // optional chaining, if it exist, then perform
                }
            }
        } catch {
            print("Weather fetch error: \(error)")
        }
    }
}
