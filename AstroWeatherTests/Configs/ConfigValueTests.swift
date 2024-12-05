//
//  ConfigValueTests.swift
//  AstroWeatherTests
//
//  Created by Luiz Rath on 12/5/24.
//

import XCTest
@testable import AstroWeather

final class ConfigValueTests: XCTestCase {
    
    // Create a mock bundle class for testing
    class MockBundle: Bundle {
        private let mockValues: [String: Any]
        
        init(mockValues: [String: Any]) {
            self.mockValues = mockValues
            super.init()
        }
        
        override func object(forInfoDictionaryKey key: String) -> Any? {
            return mockValues[key]
        }
    }
    
    func testConfigValueRetrieval() {
        // Arrange
        let mockBundle = MockBundle(mockValues: ["TEST_KEY": "mock_value"])
        let configValue = ConfigValue(key: "TEST_KEY", bundle: mockBundle)
        
        // Act
        let value = configValue.wrappedValue
        
        // Assert
        XCTAssertEqual(value, "mock_value", "ConfigValue should return the expected value from the mock bundle.")
    }
}
