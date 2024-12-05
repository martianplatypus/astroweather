//
//  WeatherRepositoryTests.swift
//  AstroWeatherTests
//
//  Created by Luiz Rath on 12/5/24.
//

import XCTest
@testable import AstroWeather

final class WeatherRepositoryTests: XCTestCase {
    fileprivate var mockAPIClient: MockAPIClient!
    var repository: WeatherRepository!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        repository = WeatherRepository(apiClient: mockAPIClient)
    }
    
    override func tearDown() {
        mockAPIClient = nil
        repository = nil
        super.tearDown()
    }
    
    func testFetchWeatherSuccess() async throws {
        // Arrange
        let mockWeather = Weather.mock()
        mockAPIClient.responseData = try JSONEncoder().encode(mockWeather)
        
        // Act
        let weather = try await repository.fetchWeather(lat: 51.5085, lon: -0.1257)
        
        // Assert
        XCTAssertEqual(weather.cityName, mockWeather.cityName, "City name should match the mock data")
        XCTAssertEqual(weather.conditions.temperature, mockWeather.conditions.temperature, "Temperature should match the mock data")
    }
    
    func testFetchWeatherFailure() async {
        // Arrange
        mockAPIClient.error = URLError(.notConnectedToInternet)
        
        do {
            // Act
            _ = try await repository.fetchWeather(lat: 51.5085, lon: -0.1257)
            XCTFail("Expected an error but did not receive one.")
        } catch {
            // Assert
            XCTAssertEqual((error as? URLError)?.code, .notConnectedToInternet, "Error should be 'not connected to the internet'")
        }
    }
    
    func testFetchWeatherForCitiesSuccess() async throws {
        // Arrange
        let mockWeatherData = WeatherRepository.mock()
        mockAPIClient.responseData = try JSONEncoder().encode(mockWeatherData.first!)
        
        // Act
        let weatherData = try await repository.fetchWeatherForCities()
        
        // Assert
        XCTAssertEqual(weatherData.count, 3, "Should return weather data for three cities")
        XCTAssertEqual(weatherData.first?.cityName, mockWeatherData.first?.cityName, "City name should match the mock data")
    }
    
    func testFetchWeatherForCitiesWithCurrentLocationSuccess() async throws {
        // Arrange
        let mockWeatherData = WeatherRepository.mock()
        mockAPIClient.responseData = try JSONEncoder().encode(mockWeatherData.first!)
        
        let currentLocationLat = -27.5954
        let currentLocationLon = -48.5480
        
        // Act
        let weatherData = try await repository.fetchWeatherForCities(currentLocation: currentLocationLat, longitude: currentLocationLon)
        
        // Assert
        XCTAssertEqual(weatherData.count, 4, "Should return weather data for three cities and the current location")
        XCTAssertEqual(weatherData.last?.cityName, mockWeatherData.first?.cityName, "City name for current location should match mock data")
    }
}

fileprivate class MockAPIClient: APIClientRequesting {
    var responseData: Data?
    var error: Error?
    
    func request<T>(_ endpoint: APIEndpointConfigurable, decoder: JSONDecoder) async throws -> T where T: Decodable {
        if let error = error {
            throw error
        }
        guard let data = responseData else {
            throw URLError(.badServerResponse)
        }
        return try decoder.decode(T.self, from: data)
    }
    
    func requestVoid(_ endpoint: APIEndpointConfigurable) async throws {
        if let error = error {
            throw error
        }
    }
}
