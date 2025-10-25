//
//  ContentView.swift
//  Smart-Driver-Assistant
//
//  Created by Lou El Idrissi on 10/25/25.
//

// Observes and displays results

import SwiftUI
import SwiftData


struct ContentView: View {
    @StateObject private var viewModel = CombinedViewModel()
    
    var body: some View {
        VStack {
            Text("Speed: \(viewModel.speed)")
            Text("Road Type: \(viewModel.roadType.rawValue)")
            Text("Time of Day: \(viewModel.timeOfDay)")
            Text("Weather: \(viewModel.weatherCondition)")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
