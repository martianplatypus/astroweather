//
//  AstroWeatherApp.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import SwiftUI

@main
struct AstroWeatherApp: App {
    @StateObject private var settings = TemperatureSettings.shared
    @StateObject private var locationManager: LocationManager
    @StateObject private var weatherDataViewModel: WeatherDataViewModel
    @State private var showLocationPermissionView: Bool
    
    init() {
        // Initialize locationManager first
        let locationManager = LocationManager()
        _locationManager = StateObject(wrappedValue: locationManager)
        // Initialize WeatherDataViewModel with locationManager
        _weatherDataViewModel = StateObject(wrappedValue: WeatherDataViewModel(locationManager: locationManager))
        // Set the initial state for showing the permission view
        _showLocationPermissionView = State(initialValue: !UserDefaults.standard.bool(forKey: "LocationPermissionGranted"))
    }
    
    var body: some Scene {
        WindowGroup {
            if showLocationPermissionView {
                LocationPermissionView(isShowingPermissionView: $showLocationPermissionView)
                    .environmentObject(locationManager)
                    .onDisappear {
                        // Refresh weather data once permission is granted
                        Task {
                            if let currentLocation = locationManager.currentLocation {
                                await weatherDataViewModel.fetchWeatherData(currentLocation: currentLocation)
                            } else {
                                await weatherDataViewModel.fetchWeatherData()
                            }
                        }
                    }
            } else {
                LocationListView()
                    .environmentObject(weatherDataViewModel)
                    .environmentObject(locationManager)
                    .onAppear {
                        settings.preferredUnit = .celsius // Default temperature unit
                        Task {
                            if let currentLocation = locationManager.currentLocation {
                                await weatherDataViewModel.fetchWeatherData(currentLocation: currentLocation)
                            } else {
                                await weatherDataViewModel.fetchWeatherData()
                            }
                        }
                    }
            }
        }
    }
}
