//
//  Wind.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

struct Wind: Codable {
    let speed: Double
    let degree: Int
    let gust: Double?
    
    enum CodingKeys: String, CodingKey {
        case speed
        case degree = "deg"
        case gust
    }
}
