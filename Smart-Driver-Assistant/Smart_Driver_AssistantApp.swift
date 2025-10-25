//
//  Smart_Driver_AssistantApp.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//

import SwiftUI
import SwiftData

@main
struct YourAppNameApp: App {
    @StateObject var locationManager = LocationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)  // to pass it down
        }
    }
}

