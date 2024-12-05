//
//  WindInfoView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI

struct WindInfoView: View {
    let windSpeed: Double
    let gustSpeed: Double?
    let windDegrees: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "wind")
                    .foregroundColor(.white.opacity(0.6))
                Text("Wind".uppercased())
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.6))
            }
            HStack(alignment: .center, spacing: 16) {
                // Left Column (Wind Details)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Wind")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(formatSpeed(windSpeed))")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    Divider()
                    
                    HStack {
                        Text("Gusts")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Spacer()
                        Text(gustSpeed != nil ? "\(formatSpeed(gustSpeed!))" : "N/A")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    Divider()
                    
                    HStack {
                        Text("Direction")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        Spacer()
                        Text("\(Int(windDegrees))° \(convertWindDirectionToCompassPoint(windDegrees))")
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.6))
                    }
                }

                Spacer()
                WindDirectionView(
                    windDegrees: windDegrees,
                    windSpeed: windSpeed,
                    speedUnit: "KM/H"
                )
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12.0))
    }
    
    private func formatSpeed(_ speed: Double) -> String {
        String(format: "%.0f km/h", speed)
    }
    
    private func convertWindDirectionToCompassPoint(_ degrees: Double) -> String {
        switch degrees {
        case 0..<11.25, 348.75..<360: return "N"
        case 11.25..<33.75: return "NNE"
        case 33.75..<56.25: return "NE"
        case 56.25..<78.75: return "ENE"
        case 78.75..<101.25: return "E"
        case 101.25..<123.75: return "ESE"
        case 123.75..<146.25: return "SE"
        case 146.25..<168.75: return "SSE"
        case 168.75..<191.25: return "S"
        case 191.25..<213.75: return "SSW"
        case 213.75..<236.25: return "SW"
        case 236.25..<258.75: return "WSW"
        case 258.75..<281.25: return "W"
        case 281.25..<303.75: return "WNW"
        case 303.75..<326.25: return "NW"
        case 326.25..<348.75: return "NNW"
        default: return "N"
        }
    }
}

#Preview {
    WindInfoView(windSpeed: 12.0, gustSpeed: 18.0, windDegrees: 157.0)
        .background(.blue)
}

