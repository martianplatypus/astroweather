//
//  AppSettingsView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/10/24.
//

import SwiftUI

struct AppSettingsView: View {
    
    @SwiftUI.Environment(\.dismiss) private var dismiss
    @AppStorage("temperatureUnit") private var temperatureSettings = 1 // Celsius
    @AppStorage("measurementUnit") private var measurementUnitSettings = 0
    @AppStorage("allowLocationSharing") private var allowLocationSharing = false
    @StateObject private var locationManager = LocationManager()
    
    @State private var showAlert = false
    @State private var isTogglingOff = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.Gradients.background
                    .ignoresSafeArea()
                List {
                    Section(header: 
                                Text("Settings")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.trailing)
                    ) {
                        HStack {
                            Text("Temperature")
                                .font(.system(size: 14))
                            Spacer()
                            Picker("", selection: $temperatureSettings) {
                                Text("F").tag(0)
                                    .font(.system(size: 14))
                                Text("C").tag(1)
                                    .font(.system(size: 14))
                            }
                            .onChange(of: temperatureSettings) { newValue in
                                TemperatureSettings.shared.preferredUnit = temperatureSettings == 1 ? .celsius : .fahrenheit
                            }
                            .pickerStyle(.segmented)
                        }
                        HStack {
                            Text("Measurements")
                                .font(.system(size: 14))
                            Spacer()
                            Picker("", selection: $measurementUnitSettings) {
                                Text("Metric").tag(0)
                                    .font(.system(size: 14))
                                Text("Imperial").tag(1)
                                    .font(.system(size: 14))
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    Section(header: 
                                Text("Privacy")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.trailing)
                    ) {
                        HStack {
                            Text("Location Sharing")
                                .font(.system(size: 14))
                            Spacer()
                            Toggle("", isOn: Binding(
                                get: {
                                    allowLocationSharing
                                },
                                set: {
                                    newValue in
                                    if !newValue {
                                        isTogglingOff = true
                                        showAlert = true
                                    } else {
                                        if locationManager.authorizationStatus == .notDetermined {
                                            locationManager.requestLocationPermission()
                                        } else if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
                                            guard let url = URL(string: "app-settings://privacy/Location") else {
                                                print("Invalid URL")
                                                return
                                            }
                                            UIApplication.shared.open(url)
                                        }
                                    }
                                })
                            )
                            .alert("Disable Location Sharing?", isPresented: $showAlert) {
                                Button("Cancel", role: .cancel) {
                                    isTogglingOff = false
                                }
                                Button("Disable", role: .destructive) {
                                    isTogglingOff = false
                                    guard let url = URL(string: "app-settings://privacy/Location") else {
                                        print("Invalid URL")
                                        return
                                    }
                                    UIApplication.shared.open(url)
                                }
                            } message: {
                                Text("Disabling location sharing will remove current location weather from the app. Are you sure?")
                            }
                        }
                    }
                }
                .background(Color.clear)
                .listStyle(.plain)
                .onAppear {
                    var toggleState = false
                    if locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways {
                        toggleState = true
                    }
                    allowLocationSharing = toggleState
                }
                .onChange(of: locationManager.authorizationStatus) { _ in
                    allowLocationSharing = locationManager.authorizationStatus == .authorizedWhenInUse || locationManager.authorizationStatus == .authorizedAlways
                }
            }
            .navigationTitle(Text("App Settings"))
            
        }
    }
}

#Preview {
    AppSettingsView()
}
