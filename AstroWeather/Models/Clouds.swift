//
//  Clouds.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

struct Clouds: Codable {
    let cloudiness: Int
    
    enum CodingKeys: String, CodingKey {
        case cloudiness = "all"
    }
}
