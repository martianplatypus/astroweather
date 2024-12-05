//
//  APIEndpointConfigurableTests.swift
//  AstroWeatherTests
//
//  Created by Luiz Rath on 12/5/24.
//

import XCTest
@testable import AstroWeather

final class APIEndpointConfigurableTests: XCTestCase {
    
    func testURLRequestGenerationSuccess() {
        // Arrange
        let endpoint = MockEndpoint(
            method: .get,
            path: "/test-path",
            baseURL: "https://api.example.com",
            headers: ["Authorization": "Bearer token"],
            urlParams: ["key": "value"],
            body: nil,
            apiVersion: .v1
        )
        
        // Act
        let urlRequest = endpoint.urlRequest
        
        // Assert
        XCTAssertNotNil(urlRequest, "URLRequest should not be nil")
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://api.example.com/2.5/test-path?key=value")
        XCTAssertEqual(urlRequest?.httpMethod, "GET")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Authorization"], "Bearer token")
    }
    
    func testURLRequestGenerationWithNoParams() {
        // Arrange
        let endpoint = MockEndpoint(
            method: .post,
            path: "/submit",
            baseURL: "https://api.example.com",
            headers: ["Content-Type": "application/json"],
            urlParams: [:],
            body: Data("{\"key\":\"value\"}".utf8),
            apiVersion: .noVersion
        )
        
        // Act
        let urlRequest = endpoint.urlRequest
        
        // Assert
        XCTAssertNotNil(urlRequest, "URLRequest should not be nil")
        XCTAssertEqual(urlRequest?.url?.absoluteString, "https://api.example.com/submit?")
        XCTAssertEqual(urlRequest?.httpMethod, "POST")
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?["Content-Type"], "application/json")
        XCTAssertEqual(urlRequest?.httpBody, Data("{\"key\":\"value\"}".utf8))
    }
    
    func testURLRequestWithMultipleQueryParameters() {
        // Arrange
        let endpoint = MockEndpoint(
            method: .get,
            path: "/search",
            baseURL: "https://api.example.com",
            headers: [:],
            urlParams: ["q": "swift", "limit": 10],
            body: nil,
            apiVersion: .v1
        )
        
        // Act
        let urlRequest = endpoint.urlRequest
        
        // Assert
        XCTAssertNotNil(urlRequest, "URLRequest should not be nil")
        XCTAssertEqual(
            urlRequest?.url?.absoluteString,
            "https://api.example.com/2.5/search?q=swift&limit=10"
        )
    }
}

enum MockHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct MockEndpoint: APIEndpointConfigurable {
    var method: HTTPMethod
    var path: String
    var baseURL: String
    var headers: [String: String]
    var urlParams: [String: any CustomStringConvertible]
    var body: Data?
    var apiVersion: APIVersion
}
