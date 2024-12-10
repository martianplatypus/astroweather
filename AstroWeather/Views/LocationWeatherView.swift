//
//  LocationWeatherView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI

struct LocationWeatherView: View {
    @EnvironmentObject var weatherDataViewModel: WeatherDataViewModel
    @StateObject private var settings = TemperatureSettings.shared
    
    let selectedWeather: Weather
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    Spacer()
                    WeatherSummaryHeaderView(
                        locationName: selectedWeather.cityName,
                        conditions: selectedWeather.weatherDetails.first?.description ?? "N/A",
                        currentTemperature: Measurement(value: selectedWeather.conditions.temperature, unit: settings.preferredUnit),
                        maximumTemperature: Measurement(value: selectedWeather.conditions.maximumTemperature, unit: settings.preferredUnit),
                        minimumTemperature: Measurement(value: selectedWeather.conditions.minimumTemperature, unit: settings.preferredUnit)
                    )
                    Spacer()
                }
                HourlyForecastView()
                    .padding(.horizontal)
                DailyForecastView()
                    .padding(.horizontal)
                HStack {
                    WeatherInfoTileView(
                        viewModel: WeatherInfoTileViewModel(
                            iconName: "sunrise.fill",
                            title: "Sunrise",
                            info: formatTime(selectedWeather.locationDetails.sunrise, timezoneOffset: selectedWeather.timezone),
                            caption: ""
                        )
                    )
                    WeatherInfoTileView(
                        viewModel: WeatherInfoTileViewModel(
                            iconName: "sunset.fill",
                            title: "Sunset",
                            info: formatTime(selectedWeather.locationDetails.sunset, timezoneOffset: selectedWeather.timezone),
                            caption: ""
                        )
                    )
                }
                .padding(.horizontal)
                HStack {
                    WeatherInfoTileView(
                        viewModel: WeatherInfoTileViewModel(
                            iconName: "humidity.fill",
                            title: "Humidity",
                            info: "\(selectedWeather.conditions.humidity)%",
                            caption: ""
                        )
                    )
                    WeatherInfoTileView(
                        viewModel: WeatherInfoTileViewModel(
                            iconName: "drop.fill",
                            title: "Precipitation",
                            info: selectedWeather.rain?.oneHour != nil ? "\(selectedWeather.rain!.oneHour!) mm" : "0 mm",
                            caption: ""
                        )
                    )
                }
                .padding(.horizontal)
                WindInfoView(
                    windSpeed: selectedWeather.wind.speed,
                    gustSpeed: selectedWeather.wind.gust,
                    windDegrees: Double(selectedWeather.wind.degree)
                )
                .padding(.horizontal)
            }
        }
        .background(.clear)
    }
    
    private func formatTime(_ timestamp: Int, timezoneOffset: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        // Create a timezone using the offset
        let timezone = TimeZone(secondsFromGMT: timezoneOffset)
        formatter.timeZone = timezone
        
        return formatter.string(from: date)
    }
}

#Preview {
    let weatherDataViewModel = WeatherDataViewModel(repository: WeatherRepository(), locationManager: LocationManager())
    weatherDataViewModel.weatherData = WeatherRepository.mock()
    
    var view = LocationWeatherView(selectedWeather: weatherDataViewModel.weatherData.first!)
        .environmentObject(weatherDataViewModel)
        .background(Theme.Gradients.background)
    
    return view
}
