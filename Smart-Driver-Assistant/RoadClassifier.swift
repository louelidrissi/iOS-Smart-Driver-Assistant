//
//  RoadClassifier.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//
import Foundation

enum RoadType: String {
    case highway, urban, rural, unknown
}

class RoadClassifier {
    static func classifyByTags(_ tag: String) -> RoadType {
        let highwayTags: Set<String> = ["motorway", "trunk", "primary", "secondary", "tertiary"]
        let urbanTags: Set<String> = ["residential", "living_street", "service", "unclassified"]
        let ruralTags: Set<String> = ["track", "road", "path", "service"]

        if highwayTags.contains(tag) { return .highway }
        if urbanTags.contains(tag) { return .urban }
        if ruralTags.contains(tag) { return .rural }
        return .unknown
    }
}
