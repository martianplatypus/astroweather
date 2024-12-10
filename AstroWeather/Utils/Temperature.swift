//
//  Temperature.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/3/24.
//

import Foundation

extension Measurement where UnitType == UnitTemperature {
    static var preferredUnit: UnitTemperature = TemperatureSettings.shared.preferredUnit
    
    // Shared formatter instance
    private static let formatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.numberFormatter.minimumFractionDigits = 0
        return formatter
    }()
    
    func toString(_ unitStyle: MeasurementFormatter.UnitStyle = .short,
                  _ unitOptions: MeasurementFormatter.UnitOptions = .temperatureWithoutUnit) -> String {
        
        let formatter = Measurement.formatter
        formatter.unitStyle = unitStyle
        formatter.unitOptions = unitOptions
        
        let convertedMeasurement = self.converted(to: Measurement.preferredUnit)
        let formattedString = formatter.string(from: convertedMeasurement)
        
        return formattedString
    }
}
