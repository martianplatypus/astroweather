//
//  Environment.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/2/24.
//

import Foundation

struct Environment {

    @ConfigValue(key: "OPEN_WEATHER_API_KEY")
    static var apiKey: String
}
