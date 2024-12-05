//
//  WeatherSummaryHeaderView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI

struct WeatherSummaryHeaderView: View {
    let locationName: String
    let conditions: String
    let currentTemperature: Measurement<UnitTemperature>
    let maximumTemperature: Measurement<UnitTemperature>
    let minimumTemperature: Measurement<UnitTemperature>
    
    var body: some View {
        VStack {
            Text(locationName)
                .font(Font.system(size: 32))
                .foregroundColor(.white)
            
            Text(currentTemperature.toString())
                .font(Font.system(size: 100))
                .fontWeight(.thin)
                .foregroundColor(.white)
            
            Text(conditions)
                .font(Font.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(.white)
            
            Text("H:\(maximumTemperature.toString()) L:\(minimumTemperature.toString())")
                .font(Font.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    WeatherSummaryHeaderView(
        locationName: "Itajaí",
        conditions: "Mostly Sunny",
        currentTemperature: Measurement(value: 25, unit: UnitTemperature.celsius),
        maximumTemperature: Measurement(value: 28.1, unit: UnitTemperature.celsius),
        minimumTemperature: Measurement(value: 16, unit: UnitTemperature.celsius)
    )
    .padding(.top, 60)
    .background(.blue)
}
