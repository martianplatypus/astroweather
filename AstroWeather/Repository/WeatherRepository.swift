//
//  WeatherRepository.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

enum WeatherEndpoint {
    case fetchWeather
}


extension WeatherEndpoint: APIEndpointConfigurable {
    var method: HTTPMethod {
        switch self {
        case .fetchWeather:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchWeather:
            return "weather" // TODO: check documentation for path
        }
    }
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/" // TODO: Set base URL using default config
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    // TODO: Obtain the coordinates from user input or current location.
    // TODO: Securely store the appid
    var urlParams: [String : any CustomStringConvertible] {
        return [
            "lat": "44.34",
            "lon": "10.99",
            "appid": Environment.apiKey
        ]
    }
    
    var body: Data? {
        return nil
    }
    
    var apiVersion: APIVersion {
        .v1 // 2.5
    }

}


final class WeatherRepository: WeatherRepositoryRequesting {
    
    let apiClient: APIClientRequesting
    private typealias apiEndpoint = APIEndpoint
    
    init(apiClient: APIClientRequesting = APIClient()) {
        self.apiClient = apiClient
    }
    
    func fetchWeather() async throws -> Weather {
        let weather: Weather = try await apiClient.request(WeatherEndpoint.fetchWeather)

        return weather
    }
}
