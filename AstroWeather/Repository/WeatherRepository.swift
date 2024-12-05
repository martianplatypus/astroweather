//
//  WeatherRepository.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

enum WeatherEndpoint: APIEndpointConfigurable {
    case fetchWeather(lat: Double, lon: Double)
    
    var method: HTTPMethod {
        switch self {
        case .fetchWeather:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchWeather:
            return "/weather"
        }
    }
    
    var baseURL: String {
        return "https://api.openweathermap.org/data"
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var urlParams: [String: any CustomStringConvertible] {
        switch self {
        case .fetchWeather(let lat, let lon):
            return [
                "lat": lat,
                "lon": lon,
                "appid": Environment.apiKey,
                "units": "metric"
            ]
        }
    }
    
    var body: Data? {
        return nil
    }
    
    var apiVersion: APIVersion {
        .v1
    }
}



final class WeatherRepository: WeatherRepositoryRequesting {
    let apiClient: APIClientRequesting
    
    init(apiClient: APIClientRequesting = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchWeather() async throws -> Weather {
        let weather: Weather = try await apiClient.request(WeatherEndpoint.fetchWeather(lat: -34.6037, lon: -58.3816))
        
        return weather
    }
    
    func fetchWeather(lat: Double, lon: Double) async throws -> Weather {
        let weather: Weather = try await apiClient.request(WeatherEndpoint.fetchWeather(lat: lat, lon: lon))
        return weather
    }
    
    func fetchWeatherForCities(currentLocation latitude: Double, longitude: Double) async throws -> [Weather] {
        let citiesCoordinates: [(lat: Double, lon: Double)] = [
            (-34.6132, -58.3772), // Buenos Aires
            (-34.8335, -56.1674), // Montevideo
            (51.5085, -0.1257),    // London
            (latitude, longitude) // Current Location
        ]
        
        return try await withThrowingTaskGroup(of: Weather.self) { group in
            var weatherData: [Weather] = []
            
            for coordinates in citiesCoordinates {
                group.addTask {
                    try await self.fetchWeather(lat: coordinates.lat, lon: coordinates.lon)
                }
            }
            
            for try await weather in group {
                weatherData.append(weather)
            }
            
            return weatherData
        }
    }
    
    func fetchWeatherForCities() async throws -> [Weather] {
        let citiesCoordinates: [(lat: Double, lon: Double)] = [
            (-34.6132, -58.3772), // Buenos Aires
            (-34.8335, -56.1674), // Montevideo
            (51.5085, -0.1257)    // London
        ]
        
        // Fetch weather data for all cities concurrently
        return try await withThrowingTaskGroup(of: Weather.self) { group in
            var weatherData: [Weather] = []
            
            for coordinates in citiesCoordinates {
                group.addTask {
                    try await self.fetchWeather(lat: coordinates.lat, lon: coordinates.lon)
                }
            }
            
            for try await weather in group {
                weatherData.append(weather)
            }
            
            return weatherData
        }
    }
}

extension WeatherRepository {
    static func mock() -> [Weather] {
        return [
            Weather(
                coordinates: Coordinates(longitude: -0.1257, latitude: 51.5085),
                weatherDetails: [
                    WeatherDetails(id: 800, main: "Clear", description: "clear sky", icon: "01d")
                ],
                base: "stations",
                conditions: WeatherConditions(
                    temperature: 12.5,
                    feelsLike: 11.0,
                    minimumTemperature: 10.0,
                    maximumTemperature: 15.0,
                    pressure: 1015,
                    humidity: 60,
                    seaLevelPressure: nil,
                    groundLevelPressure: nil
                ),
                visibility: 10000,
                wind: Wind(speed: 4.1, degree: 210, gust: 7.0),
                rain: nil,
                clouds: Clouds(cloudiness: 0),
                dateTime: 1634678400,
                locationDetails: LocationDetails(type: nil, id: nil, country: "GB", sunrise: 1634696000, sunset: 1634737200),
                timezone: 0,
                cityID: 2643743,
                cityName: "London",
                responseCode: 200
            ),
            Weather(
                coordinates: Coordinates(longitude: -56.1882, latitude: -34.9011),
                weatherDetails: [
                    WeatherDetails(id: 802, main: "Clouds", description: "scattered clouds", icon: "03d")
                ],
                base: "stations",
                conditions: WeatherConditions(
                    temperature: 20.5,
                    feelsLike: 19.0,
                    minimumTemperature: 18.0,
                    maximumTemperature: 23.0,
                    pressure: 1012,
                    humidity: 70,
                    seaLevelPressure: nil,
                    groundLevelPressure: nil
                ),
                visibility: 10000,
                wind: Wind(speed: 5.5, degree: 180, gust: 8.0),
                rain: nil,
                clouds: Clouds(cloudiness: 40),
                dateTime: 1634678400,
                locationDetails: LocationDetails(type: nil, id: nil, country: "UY", sunrise: 1634706000, sunset: 1634750400),
                timezone: -10800,
                cityID: 3441575,
                cityName: "Montevideo",
                responseCode: 200
            ),
            Weather(
                coordinates: Coordinates(longitude: -58.3816, latitude: -34.6037),
                weatherDetails: [
                    WeatherDetails(id: 803, main: "Clouds", description: "broken clouds", icon: "04d")
                ],
                base: "stations",
                conditions: WeatherConditions(
                    temperature: 22.0,
                    feelsLike: 21.0,
                    minimumTemperature: 20.0,
                    maximumTemperature: 25.0,
                    pressure: 1013,
                    humidity: 65,
                    seaLevelPressure: nil,
                    groundLevelPressure: nil
                ),
                visibility: 10000,
                wind: Wind(speed: 6.0, degree: 200, gust: 10.0),
                rain: nil,
                clouds: Clouds(cloudiness: 70),
                dateTime: 1634678400,
                locationDetails: LocationDetails(type: nil, id: nil, country: "AR", sunrise: 1634706200, sunset: 1634750600),
                timezone: -10800,
                cityID: 3435910,
                cityName: "Buenos Aires",
                responseCode: 200
            )
        ]
    }
}

