//
//  MeasurementExtensionTests.swift
//  AstroWeatherTests
//
//  Created by Luiz Rath on 12/5/24.
//

import XCTest
@testable import AstroWeather

final class MeasurementExtensionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Reset preferred unit to a known state before each test
        Measurement<UnitTemperature>.preferredUnit = .celsius
    }
    
    func testPreferredUnitCelsius() {
        // Arrange
        Measurement<UnitTemperature>.preferredUnit = .celsius
        let temperature = Measurement(value: 100, unit: UnitTemperature.celsius)
        
        // Act
        let formattedString = temperature.toString()
        
        // Assert
        XCTAssertEqual(formattedString, "100°", "Temperature should be formatted correctly in Celsius.")
    }
    
    func testPreferredUnitFahrenheit() {
        // Arrange
        Measurement<UnitTemperature>.preferredUnit = .fahrenheit
        let temperature = Measurement(value: 100, unit: UnitTemperature.celsius)
        
        // Act
        let formattedString = temperature.toString()
        
        // Assert
        XCTAssertEqual(formattedString, "212°", "Temperature should be converted and formatted correctly in Fahrenheit.")
    }
    
    func testSharedFormatterState() {
        // Arrange
        Measurement<UnitTemperature>.preferredUnit = .fahrenheit
        let temperature1 = Measurement(value: 0, unit: UnitTemperature.celsius)
        let temperature2 = Measurement(value: 100, unit: UnitTemperature.celsius)
        
        // Act
        let formattedString1 = temperature1.toString()
        let formattedString2 = temperature2.toString()
        
        // Assert
        XCTAssertEqual(formattedString1, "32°", "First temperature should be formatted correctly.")
        XCTAssertEqual(formattedString2, "212°", "Second temperature should be formatted correctly.")
    }
    
    func testUnitStyleShort() {
        // Arrange
        let temperature = Measurement(value: 100, unit: UnitTemperature.celsius)
        
        // Act
        let formattedString = temperature.toString(.short)
        
        // Assert
        XCTAssertEqual(formattedString, "100°", "Temperature should be formatted using short unit style.")
    }
    
    func testUnitOptionsTemperatureWithoutUnit() {
        // Arrange
        let temperature = Measurement(value: 100, unit: UnitTemperature.celsius)
        
        // Act
        let formattedString = temperature.toString(.short, .temperatureWithoutUnit)
        
        // Assert
        XCTAssertEqual(formattedString, "100°", "Temperature should be formatted without displaying the unit text.")
    }
}
