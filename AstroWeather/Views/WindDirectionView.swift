//
//  WindDirectionView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI

struct WindDirectionView: View {
    let windDegrees: Double
    let windSpeed: Double
    let speedUnit: String
    let frameSize: CGFloat = 140.0
    
    var body: some View {
        ZStack {
            Circle()
                .opacity(0.1)
            
            Image("compassMarker")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 80)
                .rotationEffect(Angle(degrees: windDegrees - 180))
            Circle()
                .fill(.thinMaterial)
                .opacity(0.15)
                .frame(width: frameSize / 2, height: frameSize / 2)
            
            VStack {
                Text(String(format: "%.0f", windSpeed))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.white)
                
                Text(speedUnit)
                    .font(.system(size: 12))
                    .foregroundStyle(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
            }
            
            ForEach(CompassMarker.markers(), id: \.self) { marker in
                CompassMarkerView(marker: marker, compassDegress: 0)
            }
        }
        .frame(width: frameSize, height: frameSize)
        .ignoresSafeArea()
    }
    
    struct CompassMarker: Hashable {
        let degrees: Double
        let label: String
        
        init(degrees: Double, label: String = "") {
            self.degrees = degrees
            self.label = label
        }
        
        static func markers() -> [CompassMarker] {
            return [
                CompassMarker(degrees: 0, label: "N"),
                CompassMarker(degrees: 30),
                CompassMarker(degrees: 60),
                CompassMarker(degrees: 90, label: "E"),
                CompassMarker(degrees: 120),
                CompassMarker(degrees: 150),
                CompassMarker(degrees: 180, label: "S"),
                CompassMarker(degrees: 210),
                CompassMarker(degrees: 240),
                CompassMarker(degrees: 270, label: "W"),
                CompassMarker(degrees: 300),
                CompassMarker(degrees: 330)
            ]
        }
    }
    
    struct CompassMarkerView: View {
        let marker: CompassMarker
        let compassDegress: Double
        
        var body: some View {
            VStack {
                Capsule()
                    .frame(width: 1, height: self.capsuleHeight())
                    .foregroundStyle(Color.white)
                    .opacity(0.6)
                    .padding(.bottom, self.capsulePadding())
                
                Text(marker.label)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(Color.white)
                    .opacity(0.6)
                    .rotationEffect(self.textAngle())
                
                Spacer(minLength: 97)
            }
            .rotationEffect(Angle(degrees: marker.degrees))
        }
        
        private func capsuleHeight() -> CGFloat {
            return (marker.label != "" ? 4 : 8)
        }
        
        private func capsulePadding() -> CGFloat {
            return (marker.label != "" ? -12 : -6)
        }
        
        private func textAngle() -> Angle {
            return Angle(degrees: -self.compassDegress - self.marker.degrees)
        }
    }
}

#Preview {
    WindDirectionView(windDegrees: 160.0, windSpeed: 12.5, speedUnit: "KM/H")
        .background(.blue)
}

