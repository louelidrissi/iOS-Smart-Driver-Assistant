//
//  OSMRoadClassifier.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//
import Foundation
import CoreLocation

class OSMRoadClassifier: ObservableObject {
    // String and enums with Sendable fields are Sendable
    // mutable that manages changing internal data reflecting the current road type
    @Published var roadType: RoadType = .unknown
    // use let to initiate a single, immutable instance of a globally accessible shared resource.
    // use static to make property or method belong to the type itself, rather than to any particular instance of that type.
    static let shared = OSMRoadClassifier()
    
    // roadType represents the internal state change of singleton instance conventionally named shared accessible app-wide
    
    private let overpassURL = "https://overpass-api.de/api/interpreter"

    func classifyRoad(at location: CLLocation) {
        let query = """
        [out:json];
        (
          way(around:50,\(location.coordinate.latitude),\(location.coordinate.longitude))[highway];
        );
        out tags 1;
        """

        guard let url = URL(string: overpassURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = query.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { self.roadType = .unknown }
                return
            }
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let elements = json["elements"] as? [[String: Any]] {
                    for element in elements {
                        if let tags = element["tags"] as? [String: String],
                           let highwayTag = tags["highway"] {
                            DispatchQueue.main.async {
                                self.roadType = RoadClassifier.classifyByTags(highwayTag)
                            }
                            return
                        }
                    }
                }
                DispatchQueue.main.async { self.roadType = .unknown }
            } catch {
                DispatchQueue.main.async { self.roadType = .unknown }
            }
        }
        task.resume()
    }
}

