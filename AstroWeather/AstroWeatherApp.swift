//
//  AstroWeatherApp.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import SwiftUI

@main
struct AstroWeatherApp: App {
    @StateObject private var settings: TemperatureSettings
    @StateObject private var locationManager: LocationManager
    @StateObject private var weatherDataViewModel: WeatherDataViewModel
    @State private var showLocationPermissionView: Bool
    @AppStorage("temperatureUnit") private var temperatureSettings = 1
    
    init() {
        // Initialize locationManager first
        let locationManager = LocationManager()
        _locationManager = StateObject(wrappedValue: locationManager)
        // Initialize WeatherDataViewModel with locationManager
        _weatherDataViewModel = StateObject(wrappedValue: WeatherDataViewModel(locationManager: locationManager))
        // Set the initial state for showing the permission view
        _showLocationPermissionView = State(initialValue: !UserDefaults.standard.bool(forKey: "OnboardingCompleted"))
        _settings = StateObject(wrappedValue: TemperatureSettings.shared)
    }
    
    var body: some Scene {
        WindowGroup {
            if showLocationPermissionView {
                LocationPermissionView(isShowingPermissionView: $showLocationPermissionView)
                    .environmentObject(locationManager)
            } else {
                LocationListView()
                    .environmentObject(weatherDataViewModel)
                    .environmentObject(locationManager)
                    .onAppear {
                        Task {
                            await weatherDataViewModel.fetchWeatherData(currentLocation: locationManager.currentLocation)
                        }
                    }
            }
        }
    }
}
