//
//  Rain.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

struct Rain: Codable {
    let oneHour: Double?
    
    enum CodingKeys: String, CodingKey {
        case oneHour = "1h"
    }
}
