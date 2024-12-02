//
//  WeatherRepositoryRequesting.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

struct Weather: Codable {
    let coordinates: Coordinates
    let weatherDetails: [WeatherDetails]
    let base: String
    let conditions: WeatherConditions
    let visibility: Int
    let wind: Wind
    let rain: Rain?
    let clouds: Clouds
    let dateTime: Int
    let locationDetails: LocationDetails
    let timezone: Int
    let cityID: Int
    let cityName: String
    let responseCode: Int
    
    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case weatherDetails = "weather"
        case base
        case conditions = "main"
        case visibility
        case wind
        case rain
        case clouds
        case dateTime = "dt"
        case locationDetails = "sys"
        case timezone
        case cityID = "id"
        case cityName = "name"
        case responseCode = "cod"
    }
}
