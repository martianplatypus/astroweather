//
//  WeatherDataViewModelTests.swift
//  AstroWeatherTests
//
//  Created by Luiz Rath on 12/5/24.
//

import CoreLocation
import XCTest
@testable import AstroWeather

final class WeatherDataViewModelTests: XCTestCase {
    var viewModel: WeatherDataViewModel!
    var mockRepository: MockWeatherRepository!
    var mockLocationManager: MockLocationManager!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockWeatherRepository()
        mockLocationManager = MockLocationManager()
        viewModel = WeatherDataViewModel(repository: mockRepository, locationManager: mockLocationManager)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        mockLocationManager = nil
        super.tearDown()
    }
    
    func testFetchWeatherDataSuccess() async {
        // Arrange
        mockRepository.mockWeatherData = [Weather.mock()]
        
        // Act
        await viewModel.fetchWeatherData()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading, "Loading should be false after fetch completes.")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil on success.")
        XCTAssertEqual(viewModel.weatherData.count, 1, "Weather data should contain one item.")
        XCTAssertEqual(viewModel.weatherData.first?.cityName, "Florianópolis", "Mock weather data should be returned.")
    }
    
    func testFetchWeatherDataFailure() async {
        // Arrange
        mockRepository.shouldThrowError = true
        
        // Act
        await viewModel.fetchWeatherData()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading, "Loading should be false after fetch completes.")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should not be nil on failure.")
        XCTAssertEqual(viewModel.weatherData.count, 0, "Weather data should be empty on failure.")
    }
    
    func testFetchWeatherDataWithLocationSuccess() async {
        // Arrange
        let mockLocation = CLLocation(latitude: 37.7749, longitude: -122.4194)
        mockLocationManager.simulateLocation = mockLocation
        mockRepository.mockWeatherData = [Weather.mock()]
        
        // Act
        mockLocationManager.startUpdatingLocation()
        
        // Assert
        try? await Task.sleep(nanoseconds: 100_000_000) // Allow async task to complete
        XCTAssertFalse(viewModel.isLoading, "Loading should be false after fetch completes.")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil on success.")
        XCTAssertEqual(viewModel.weatherData.count, 1, "Weather data should contain one item.")
        XCTAssertEqual(viewModel.weatherData.first?.cityName, "Florianópolis", "Mock weather data should be returned.")
    }
    
    func testFetchWeatherDataWithLocationFailure() async {
        // Arrange
        let mockLocation = CLLocation(latitude: 37.7749, longitude: -122.4194)
        mockLocationManager.simulateLocation = mockLocation
        mockRepository.shouldThrowError = true
        
        // Act
        mockLocationManager.startUpdatingLocation()
        
        // Assert
        try? await Task.sleep(nanoseconds: 100_000_000) // Allow async task to complete
        XCTAssertFalse(viewModel.isLoading, "Loading should be false after fetch completes.")
        XCTAssertNotNil(viewModel.errorMessage, "Error message should not be nil on failure.")
        XCTAssertEqual(viewModel.weatherData.count, 0, "Weather data should be empty on failure.")
    }
    
    func testFetchWeatherDataDoesNotRefetchForSameLocation() async {
        // Arrange
        let mockLocation = CLLocation(latitude: 37.7749, longitude: -122.4194)
        mockLocationManager.simulateLocation = mockLocation
        mockRepository.mockWeatherData = [Weather.mock()]
        
        // Act
        mockLocationManager.startUpdatingLocation()
        mockLocationManager.startUpdatingLocation() // Trigger location update again
        
        // Assert
        try? await Task.sleep(nanoseconds: 200_000_000) // Allow async task to complete
        
        XCTAssertEqual(viewModel.weatherData.count, 1, "Weather data should only be fetched once for the same location.")
    }
}

class MockWeatherRepository: WeatherRepositoryRequesting {
    func fetchWeather() async throws -> AstroWeather.Weather {
        return try await fetchWeatherForCities().first!
    }
    
    var shouldThrowError = false
    var mockWeatherData: [Weather] = []
    
    func fetchWeatherForCities() async throws -> [Weather] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return mockWeatherData
    }
    
    func fetchWeatherForCities(currentLocation latitude: Double, longitude: Double) async throws -> [Weather] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return mockWeatherData
    }
}

class MockLocationManager: LocationManager {
    var simulateLocation: CLLocation?
    
    override func startUpdatingLocation() {
        if let location = simulateLocation {
            self.onLocationUpdate?(location)
        }
    }
}
