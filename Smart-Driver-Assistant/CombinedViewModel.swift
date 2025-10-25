//
//  ViewModel.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//
import Foundation
import Combine
import CoreLocation

final class CombinedViewModel: ObservableObject {
    @Published var locationData: LocationData?
    @Published var speed: CLLocationSpeed = 0.0
    @Published var roadType: RoadType = .unknown
    @Published var timeOfDay: String = ""
    @Published var weatherCondition: String = ""
    
    // cancellables ensures view model to stay subscribed to publishers during its lifetime.
    // otherwise, subscriptions get cancelled
    private var cancellables = Set<AnyCancellable>()
    
    private let locationManager = LocationManager()
    private let roadClassifier = OSMRoadClassifier.shared
    private let timeService = TimeOfDayService()
    private let weatherService = WeatherService()
    
    init() {
        // Use Binding to connect the published properties to view model’s @Published properties.
        // Uses Combine's .sink and .assign with a cancellables set to manage subscriptions and memory.
        locationManager.$locationData
            .sink { [weak self] locationData in // Weak self is used in the sink closure to prevent retain cycles and memory leaks.
                guard let self = self, let locationData = locationData else { return }
                self.locationData = locationData
                self.speed = self.locationManager.speed // speed is not an independently observable publisher, so there is no need to bind it.
                
                // Classify road type asynchronously
                //if let locationData = locationData { //handles nil cases
                let clLocation = CLLocation(from: locationData)
                self.roadClassifier.classifyRoad(at: clLocation)
                
                    
                // Update time of day based on location's timestamp
                self.timeService.updateTimeOfDay(from: locationData.timestamp)
                
                // Fetch weather asynchronously using Swift concurrency's Task
                Task {
                    await self.weatherService.fetchWeather(
                        latitude: locationData.latitude,
                        longitude: locationData.longitude,
                        apiKey: Secrets.apiKey
                    )
                }
            
                // Call saveDataSnapshot here after updates:
                DataStorageManager.shared.save(snapshot: DataSnapshot(
                    speed: self.speed,
                    roadType: self.roadType.rawValue,
                    weatherCondition: self.weatherCondition,
                    timeOfDay: self.timeOfDay,
                    timestamp: Date()
                ))
                }
                .store(in: &cancellables)
                
                // Bind roadType from roadClassifier to this view model
                roadClassifier.$roadType
                    .assign(to: &$roadType)
                
                // Bind timeOfDay from timeService to this view model
                timeService.$timeOfDay
                    .assign(to: &$timeOfDay)
                
                // Bind weatherCondition from weatherService to this view model
                weatherService.$currentWeatherCondition
                    .assign(to: &$weatherCondition)
            }
    }

