//
//  WeatherRepositoryRequesting.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

protocol WeatherRepositoryRequesting {
    func fetchWeather() async throws -> Weather
    func fetchWeatherForCities() async throws -> [Weather]
    func fetchWeatherForCities(currentLocation latitude: Double, longitude: Double) async throws -> [Weather]
}
