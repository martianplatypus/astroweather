//
//  HourlyForecastView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI

struct HourlyForecastView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(systemName: "clock")
                    .foregroundColor(.white)
                    .opacity(0.6)
                Text("Hourly Forecast".uppercased())
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.6))
            }
            .padding(.top)
            .padding(.horizontal)
            Divider()
                .background(.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<23) { _ in
                        VStack {
                            HourlyForecastInfoView()
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12.0))
    }
}

struct HourlyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            HourlyForecastView()
        }
        .padding()
        .background(.blue)
    }
}
