//
//  WeatherConditions.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

// MARK: - WeatherConditions
struct WeatherConditions: Codable {
    let temperature: Double
    let feelsLike: Double
    let minimumTemperature: Double
    let maximumTemperature: Double
    let pressure: Int
    let humidity: Int
    let seaLevelPressure: Int?
    let groundLevelPressure: Int?
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case pressure
        case humidity
        case seaLevelPressure = "sea_level"
        case groundLevelPressure = "grnd_level"
    }
}
