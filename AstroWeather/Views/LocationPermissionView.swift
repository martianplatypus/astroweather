//
//  LocationPermissionView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/5/24.
//

import SwiftUI
import CoreLocation

struct LocationPermissionView: View {
    @EnvironmentObject var locationManager: LocationManager
    @Binding var isShowingPermissionView: Bool
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                Text("We need your location")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                
                Text("Allow us to access your location to provide accurate weather data for your area.")
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                
                Button(action: {
                    locationManager.requestLocationPermission()
                    isShowingPermissionView = false
                }) {
                    Text("Enable Location Access")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .foregroundColor(.blue)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 16)
            }
            .padding()
        }
    }
}

struct LocationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPermissionView(isShowingPermissionView: .constant(true))
            .environmentObject(LocationManager())
    }
}
