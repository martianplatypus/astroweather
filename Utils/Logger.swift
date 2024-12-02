//
//  Logger.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/1/24.
//

import Foundation

protocol Logging {
    func log(_ string: String)
}

final class Logger: Logging {
    func log(_ string: String) {
#if DEBUG
        print(string)
#endif
    }
}
