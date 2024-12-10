//
//  Colors.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/9/24.
//

import SwiftUI

struct Theme {
    // MARK: - Colors
    struct Colors {
        static let primary = Color.blue
        static let secondary = Color.purple
        static let backgroundGradientStart = Color.blue
        static let backgroundGradientEnd = Color.purple
    }
    
    // MARK: - Gradients
    struct Gradients {
        static let background = LinearGradient(
            gradient: Gradient(colors: [Colors.backgroundGradientStart, Colors.backgroundGradientEnd]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // MARK: - Fonts
    struct Fonts {
        static let title = Font.system(size: 24, weight: .bold)
        static let subtitle = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 14, weight: .regular)
    }
}
