//
//  SaveData.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//
import Foundation
import CoreLocation

struct DataSnapshot: Codable {
    let speed: Double
    let roadType: String
    let weatherCondition: String
    let timeOfDay: String
    let timestamp: Date
}

class DataStorageManager {
    static let shared = DataStorageManager()
    
    // Save JSON snapshot
    func save(snapshot: DataSnapshot) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(snapshot)
            
            if let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileUrl = documentsDir.appendingPathComponent("snapshot_\(Int(Date().timeIntervalSince1970)).json")
                try data.write(to: fileUrl)
                print("Data saved to \(fileUrl.path)")
            }
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    
    
}
