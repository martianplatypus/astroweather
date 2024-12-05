//
//  APIEndpoint.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

private enum Constants {
    static let baseURL = ""    
    static let contentTypeHeader = "Content-Type"
}

enum APIEndpoint { }

extension APIEndpoint: APIEndpointConfigurable {
    var apiVersion: APIVersion {
        .v1
    }
    
    var baseURL: String {
        return Constants.baseURL
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return ""
    }
    
    var headers: [String: String] {
        return [:]
    }
    
    var urlParams: [String: any CustomStringConvertible] {
        return [:]
    }
    
    var body: Data? {
        return nil
    }
}

