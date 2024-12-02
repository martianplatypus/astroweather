//
//  ContentView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task {
                do {
                    let repository = WeatherRepository()
                    let weather = try await repository.fetchWeather()
                    print("Network response: \(weather)")
                } catch {
                    print("Error fetching weather: \(error)")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
