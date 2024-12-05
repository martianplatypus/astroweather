//
//  APIClientRequesting.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

protocol APIClientRequesting {
    func request<T: Codable>(
        _ endpoint: APIEndpointConfigurable,
        decoder: JSONDecoder
    ) async throws -> T
    
    func requestVoid(
        _ endpoint: APIEndpointConfigurable
    ) async throws
}

extension APIClientRequesting {
    @discardableResult
    func request<T: Codable>(_ endpoint: APIEndpointConfigurable) async throws -> T {
        try await request(endpoint, decoder: JSONDecoder())
    }
}
