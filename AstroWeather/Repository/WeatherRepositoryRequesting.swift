//
//  WeatherRepositoryRequesting.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

protocol WeatherRepositoryRequesting {
    func fetchWeather() async throws -> Weather
}
