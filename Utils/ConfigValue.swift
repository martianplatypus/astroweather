//
//  ConfigValue.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/2/24.
//

import Foundation

@propertyWrapper
struct ConfigValue {
    private let key: String
    private let bundle: Bundle
    
    init(key: String, bundle: Bundle = .main) {
        self.key = key
        self.bundle = bundle
    }
    
    var wrappedValue: String {
        guard let value = bundle.object(forInfoDictionaryKey: key) as? String else {
            fatalError("Unable to obtain value for key '\(key)' from Info.plist or environment")
        }
        
        return value
    }
}
