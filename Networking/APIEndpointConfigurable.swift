//
//  APIEndpointProtocol.swift
//  Dogoland
//
//  Created by Luiz Rath on 10/14/24.
//

import Foundation

enum APIVersion: String {
    case v1 = "/v1/"
    case noVersion = ""
}

protocol APIEndpointConfigurable {
    var method: HTTPMethod { get }
    var path: String { get }
    var baseURL: String { get }
    var headers: [String: String] { get }
    var urlParams: [String: any CustomStringConvertible] { get }
    var body: Data? { get }
    var urlRequest: URLRequest? { get }
    var apiVersion: APIVersion { get }
}

extension APIEndpointConfigurable {

    var urlRequest: URLRequest? {
        var components = URLComponents(string: baseURL + apiVersion.rawValue + path)
        components?.queryItems = urlParams.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        return request
    }
}
