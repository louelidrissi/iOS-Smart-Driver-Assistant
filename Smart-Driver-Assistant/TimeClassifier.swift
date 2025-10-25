//
//  TimeClassifier.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//

import Foundation

class TimeOfDayService: ObservableObject {
    // String and enums with Sendable fields are Sendable
    @Published var timeOfDay: String = ""

    func updateTimeOfDay(from date: Date) {
        let hour = Calendar.current.component(.hour, from: date)
        switch hour {
        case 6..<12: timeOfDay = "Morning"
        case 12..<18: timeOfDay = "Afternoon"
        case 18..<22: timeOfDay = "Evening"
        default: timeOfDay = "Night"
        }
    }
}

