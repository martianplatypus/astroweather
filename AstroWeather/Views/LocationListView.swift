//
//  LocationListView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI

struct LocationListView: View {
    @EnvironmentObject var weatherDataViewModel: WeatherDataViewModel
    @EnvironmentObject var locationManager: LocationManager
    
    @State private var isShowingDetail = true // Start with TabView by default
    @State private var selectedCityIndex: Int = UserDefaults.standard.integer(forKey: "LastViewedCityIndex")
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            if weatherDataViewModel.isLoading {
                VStack {
                    ProgressView("Loading weather data...")
                        .foregroundColor(.white)
                        .padding()
                }
            } else if let errorMessage = weatherDataViewModel.errorMessage {
                VStack {
                    Text("Error")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    Text(errorMessage)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                    
                    Button(action: {
                        Task {
                            await weatherDataViewModel.fetchWeatherData()
                        }
                    }) {
                        Text("Retry")
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    .foregroundColor(.blue)
                }
                .padding()
            } else if isShowingDetail && !weatherDataViewModel.weatherData.isEmpty {
                detailView
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Weather")
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Button(action: {
                            Task {
                                await weatherDataViewModel.fetchWeatherData()
                            }
                        }) {
                            Image(systemName: "arrow.clockwise")
                                .font(.title2)
                                .padding(8)
                                .background(Circle().fill(Color.white.opacity(0.8)))
                        }
                        .foregroundColor(.blue)
                    }
                    .padding(.horizontal)
                    
                    ScrollView {
                        VStack(spacing: 8) {
                            ForEach(weatherDataViewModel.weatherData, id: \.cityID) { weather in
                                LocationRowView(
                                    cityName: weather.cityName,
                                    weatherDescription: weather.weatherDetails.first?.description ?? "N/A",
                                    currentTime: "3:45 PM",
                                    isCurrentLocation: weather.cityID == -1,
                                    currentTemperature: Measurement(value: weather.conditions.temperature, unit: .celsius),
                                    highTemperature: Measurement(value: weather.conditions.maximumTemperature, unit: .celsius),
                                    lowTemperature: Measurement(value: weather.conditions.minimumTemperature, unit: .celsius)
                                )
                                .onTapGesture {
                                    withAnimation {
                                        if let index = weatherDataViewModel.weatherData.firstIndex(where: { $0.cityID == weather.cityID }) {
                                            selectedCityIndex = index
                                            isShowingDetail = true
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .onAppear {
            Task {
                if weatherDataViewModel.weatherData.isEmpty {
                    if let location = locationManager.currentLocation {
                        await weatherDataViewModel.fetchWeatherData(currentLocation: location)
                    } else {
                        await weatherDataViewModel.fetchWeatherData()
                    }
                }
            }
            
            if !weatherDataViewModel.weatherData.indices.contains(selectedCityIndex) {
                selectedCityIndex = 0
            }
        }
        .onChange(of: selectedCityIndex) { newValue in
            UserDefaults.standard.set(newValue, forKey: "LastViewedCityIndex")
        }
    }
    
    private var detailView: some View {
        VStack {
            if !weatherDataViewModel.weatherData.indices.contains(selectedCityIndex) {
                EmptyView()
            } else {
                TabView(selection: $selectedCityIndex) {
                    ForEach(weatherDataViewModel.weatherData.indices, id: \.self) { index in
                        LocationWeatherView(selectedWeather: weatherDataViewModel.weatherData[index])
                            .tag(index)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .onChange(of: selectedCityIndex) { newValue in
                    UserDefaults.standard.set(newValue, forKey: "LastViewedCityIndex")
                }
                .overlay(
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation {
                                    isShowingDetail = false
                                }
                            }) {
                                Image(systemName: "line.horizontal.3")
                                    .font(.title)
                                    .padding()
                                    .background(Circle().fill(Color.white.opacity(0.8)))
                            }
                            .padding(.trailing, 16)
                        }
                    }
                )
            }
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        let weatherDataViewModel = WeatherDataViewModel(repository: WeatherRepository(), locationManager: LocationManager())
        weatherDataViewModel.weatherData = WeatherRepository.mock()
        
        return LocationListView()
            .environmentObject(weatherDataViewModel)
    }
}
