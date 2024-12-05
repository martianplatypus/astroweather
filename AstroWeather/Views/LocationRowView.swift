//
//  LocationRowView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI
import SwiftUI

struct LocationRowView: View {
    let cityName: String
    let weatherDescription: String
    let currentTime: String?
    let isCurrentLocation: Bool
    let currentTemperature: Measurement<UnitTemperature>
    let highTemperature: Measurement<UnitTemperature>
    let lowTemperature: Measurement<UnitTemperature>
    
    @EnvironmentObject var settings: TemperatureSettings
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(cityName)
                    .font(.system(size: 20))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                Text(isCurrentLocation ? "My Location" : (currentTime ?? ""))
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                Spacer()
                Text(weatherDescription)
                    .font(.system(size: 12))
                    .fontWeight(.light)
                    .foregroundColor(.white)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(currentTemperature.toString())")
                    .font(.system(size: 40))
                    .fontWeight(.thin)
                    .foregroundColor(.white)
                Spacer()
                Text("H:\(highTemperature.toString()) L:\(lowTemperature.toString())")
                    .font(.system(size: 12))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12.0))
        .cornerRadius(20)
    }
}

struct LocationRowView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack {
                LocationRowView(
                    cityName: "São José",
                    weatherDescription: "Mostly Cloudy",
                    currentTime: "3:45 PM",
                    isCurrentLocation: true,
                    currentTemperature: Measurement(value: 24, unit: .celsius),
                    highTemperature: Measurement(value: 26, unit: .celsius),
                    lowTemperature: Measurement(value: 20, unit: .celsius)
                )
            }
        }
        .background(.blue)
    }
}

