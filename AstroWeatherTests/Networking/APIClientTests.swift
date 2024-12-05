//
//  APIClientTests.swift
//  AstroWeatherTests
//
//  Created by Luiz Rath on 12/5/24.
//

import XCTest
@testable import AstroWeather

final class APIClientTests: XCTestCase {
    fileprivate var mockAPIClient: MockAPIClient!
    var testEndpoint: APIEndpointConfigurable!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        testEndpoint = TestEndpoint() // Define a TestEndpoint conforming to APIEndpointConfigurable
    }
    
    override func tearDown() {
        mockAPIClient = nil
        testEndpoint = nil
        super.tearDown()
    }
    
    func testRequestSuccess() async throws {
        // Arrange
        
        let expectedResponse = MockResponse(id: 1, name: "Test")
        let responseData = try JSONEncoder().encode(expectedResponse)
        mockAPIClient.responseData = responseData
        
        // Act
        let response: MockResponse = try await mockAPIClient.request(testEndpoint)
        
        // Assert
        XCTAssertEqual(response, expectedResponse, "The response should match the expected mock response.")
    }
    
    func testRequestFailure() async {
        // Arrange
        mockAPIClient.error = URLError(.notConnectedToInternet)
        
        // Act & Assert
        do {
            _ = try await mockAPIClient.request(testEndpoint) as MockResponse
            XCTFail("The request should have thrown an error, but it succeeded.")
        } catch {
            // Assert the error type and code
            if let urlError = error as? URLError {
                XCTAssertEqual(urlError.code, .notConnectedToInternet, "The error should be a 'not connected to the internet' error.")
            } else {
                XCTFail("Unexpected error type: \(error)")
            }
        }
    }
    
    func testRequestVoidSuccess() async throws {
        // Arrange
        mockAPIClient.responseData = Data() // Simulate a successful void response
        
        // Act & Assert
        do {
            try await mockAPIClient.requestVoid(testEndpoint)
            // If no error is thrown, the test passes
        } catch {
            XCTFail("Void request should succeed without throwing an error, but threw: \(error)")
        }
    }
    
    func testRequestVoidFailure() async {
        // Arrange
        mockAPIClient.error = URLError(.timedOut)
        
        // Act & Assert
        do {
            try await mockAPIClient.requestVoid(testEndpoint)
            XCTFail("Void request should have thrown an error, but it succeeded.")
        } catch {
            // Assert the error type and code
            if let urlError = error as? URLError {
                XCTAssertEqual(urlError.code, .timedOut, "The error should be a 'timed out' error.")
            } else {
                XCTFail("Unexpected error type: \(error)")
            }
        }
    }
}

fileprivate class MockAPIClient: APIClientRequesting {
    var responseData: Data?
    var error: Error?
    
    func request<T: Codable>(
        _ endpoint: APIEndpointConfigurable,
        decoder: JSONDecoder
    ) async throws -> T {
        if let error = error {
            throw error
        }
        
        guard let data = responseData else {
            throw URLError(.badServerResponse)
        }
        
        return try decoder.decode(T.self, from: data)
    }
    
    func requestVoid(_ endpoint: APIEndpointConfigurable) async throws {
        if let error = error {
            throw error
        }
    }
}

struct MockResponse: Codable, Equatable {
    let id: Int
    let name: String
}

struct TestEndpoint: APIEndpointConfigurable {
    var method: HTTPMethod { .get }
    var path: String { "/test" }
    var baseURL: String { "https://api.example.com" }
    var headers: [String: String] { [:] }
    var urlParams: [String: CustomStringConvertible] { [:] }
    var body: Data? { nil }
    var apiVersion: APIVersion { .v1 }
}


