//
//  TemperatureSettingsTests.swift
//  AstroWeatherTests
//
//  Created by Luiz Rath on 12/5/24.
//

import XCTest
@testable import AstroWeather

final class TemperatureSettingsTests: XCTestCase {
    
    var temperatureSettings: TemperatureSettings!
    
    override func setUpWithError() throws {
        // Initialize the shared instance before each test
        temperatureSettings = TemperatureSettings.shared
    }
    
    override func tearDownWithError() throws {
        // Reset the shared instance after each test
        temperatureSettings.preferredUnit = .celsius
        temperatureSettings = nil
    }
    
    func testInitialPreferredUnit() throws {
        // Verify that the initial preferred unit is .celsius
        XCTAssertEqual(temperatureSettings.preferredUnit, .celsius, "Initial preferred unit should be Celsius")
    }
    
    func testPreferredUnitChange() throws {
        // Change the preferred unit to Fahrenheit
        temperatureSettings.preferredUnit = .fahrenheit
        
        // Verify that the preferred unit is updated correctly
        XCTAssertEqual(temperatureSettings.preferredUnit, .fahrenheit, "Preferred unit should be updated to Fahrenheit")
    }
    
    func testPreferredUnitAffectsMeasurement() throws {
        // Change the preferred unit
        temperatureSettings.preferredUnit = .fahrenheit
        
        // Verify that the Measurement's preferred unit is also updated
        XCTAssertEqual(Measurement<UnitTemperature>.preferredUnit, .fahrenheit, "Measurement's preferred unit should match TemperatureSettings")
        
        // Change the preferred unit back to Celsius
        temperatureSettings.preferredUnit = .celsius
        
        // Verify that the Measurement's preferred unit is updated again
        XCTAssertEqual(Measurement<UnitTemperature>.preferredUnit, .celsius, "Measurement's preferred unit should match TemperatureSettings")
    }
}

