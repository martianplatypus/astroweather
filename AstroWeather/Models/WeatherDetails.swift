//
//  WeatherDetails.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

struct WeatherDetails: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
