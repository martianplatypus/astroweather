//
//  WeatherDataViewModel.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/5/24.
//

import SwiftUI
import CoreLocation

final class WeatherDataViewModel: ObservableObject {
    @Published var weatherData: [Weather] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let repository: WeatherRepositoryRequesting
    private var didFetchForCurrentLocation: Bool = false // Tracks whether current location has been fetched
    
    init(repository: WeatherRepositoryRequesting = WeatherRepository(), locationManager: LocationManager) {
        self.repository = repository
        
        locationManager.onLocationUpdate = { [weak self] location in
            guard let self = self else { return }
            if !self.didFetchForCurrentLocation {
                self.didFetchForCurrentLocation = true
                Task {
                    await self.fetchWeatherData(currentLocation: location)
                }
            }
        }
    }
    
    @MainActor
    func fetchWeatherData(currentLocation: CLLocation? = nil) async {
        isLoading = true
        errorMessage = nil
        
        do {
            var data: [Weather] = []
            if let location = currentLocation {
                data = try await repository.fetchWeatherForCities(
                    currentLocation: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                )
            } else {
                data = try await repository.fetchWeatherForCities()
            }
            weatherData = data
        } catch {
            errorMessage = "Failed to fetch weather data: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
