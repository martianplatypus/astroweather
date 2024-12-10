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

extension Weather {
    func localTimeToString() -> String {
        let locationTime = Date(timeIntervalSince1970: TimeInterval(self.dateTime))
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.timeZone = TimeZone(secondsFromGMT: self.timezone)

        let locationTimeToString = formatter.string(from: locationTime)
        
        return locationTimeToString
    }
}


extension Weather {
    static func mock() -> Weather {
        return Weather(
            coordinates: Coordinates.mock(),
            weatherDetails: [WeatherDetails.mock()],
            base: "stations",
            conditions: WeatherConditions.mock(),
            visibility: 10000,
            wind: Wind.mock(),
            rain: Rain.mock(),
            clouds: Clouds.mock(),
            dateTime: Int(Date().timeIntervalSince1970),
            locationDetails: LocationDetails.mock(),
            timezone: -10800, // Florianópolis timezone in seconds (UTC-3)
            cityID: 3463237,
            cityName: "Florianópolis",
            responseCode: 200
        )
    }
}

extension Coordinates {
    static func mock() -> Coordinates {
        return Coordinates(
            longitude: -48.5480,
            latitude: -27.5954
        )
    }
}

extension WeatherDetails {
    static func mock() -> WeatherDetails {
        return WeatherDetails(
            id: 800,
            main: "Clear",
            description: "clear sky",
            icon: "01d"
        )
    }
}

extension WeatherConditions {
    static func mock() -> WeatherConditions {
        return WeatherConditions(
            temperature: 25.0,
            feelsLike: 24.5,
            minimumTemperature: 20.0,
            maximumTemperature: 28.0,
            pressure: 1013,
            humidity: 78,
            seaLevelPressure: 1013,
            groundLevelPressure: 1009
        )
    }
}

extension LocationDetails {
    static func mock() -> LocationDetails {
        return LocationDetails(
            type: 1,
            id: 123,
            country: "BR",
            sunrise: Int(Date().addingTimeInterval(-60 * 60 * 6).timeIntervalSince1970),
            sunset: Int(Date().addingTimeInterval(60 * 60 * 6).timeIntervalSince1970)
        )
    }
}

extension Wind {
    static func mock() -> Wind {
        return Wind(
            speed: 3.5,
            degree: 120,
            gust: 5.0
        )
    }
}

extension Rain {
    static func mock() -> Rain {
        return Rain(
            oneHour: 0.0
        )
    }
}

extension Clouds {
    static func mock() -> Clouds {
        return Clouds(
            cloudiness: 10
        )
    }
}
