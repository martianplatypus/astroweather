//
//  TemperatureSettings.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/3/24.
//

import Foundation

final class TemperatureSettings: ObservableObject {
    
    static let shared = TemperatureSettings()
    
    @Published var preferredUnit: UnitTemperature = .celsius {
        didSet {
            Measurement<UnitTemperature>.preferredUnit = preferredUnit
        }
    }
}
