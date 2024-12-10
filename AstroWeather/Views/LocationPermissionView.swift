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
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            Theme.Gradients.background
                .ignoresSafeArea(.all)
            
            VStack(spacing: 16) {
                Text("We need your location")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                CompassCalibrationView()
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
                Button(action: {
                    showAlert = true
                    
                }) {
                    Text("Not now")
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
            .alert("Location Access", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {
                    showAlert = false
                }
                Button("Continue") {
                    isShowingPermissionView = false
                    UserDefaults.standard.set(true, forKey: "OnboardingCompleted")
                }
            } message: {
                Text("You can enable location access later in the app settings")
            }
        }
    }
}

struct CompassCalibrationView: View {
    @State private var rotationAngle: Double = Double(Int.random(in: -45...45))
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            Image(systemName: "location.north")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .symbolRenderingMode(.hierarchical)
                .font(.system(size: 80, weight: .thin))
                .foregroundColor(.white)
                .rotationEffect(.degrees(rotationAngle))
                .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: rotationAngle)
        }
        .onAppear {
            startCompassCalibrationAnimation()
        }
    }
    
    private func startCompassCalibrationAnimation() {
        rotationAngle = Double(Int.random(in: -45...45))
        isAnimating = true
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            rotationAngle = Double(Int.random(in: -45...45))
        }
    }
}

struct LocationPermissionView_Previews: PreviewProvider {
    static var previews: some View {
        LocationPermissionView(isShowingPermissionView: .constant(true))
            .environmentObject(LocationManager())
    }
}
