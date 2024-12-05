//
//  DailyForecastView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI

struct DailyForecastView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(systemName: "calendar")
                    .foregroundColor(.white)
                    .opacity(0.6)
                Text("5-Day Forecast".uppercased())
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.6))
            }
            .padding(.top)
            .padding(.horizontal)
            Divider()
                .background(.white)
            ScrollView {
                VStack {
                    DailyForecastRowView()
                    Divider()
                        .background(.white)
                    DailyForecastRowView()
                    Divider()
                        .background(.white)
                    DailyForecastRowView()
                    Divider()
                        .background(.white)
                    DailyForecastRowView()
                    Divider()
                        .foregroundColor(.white)
                    DailyForecastRowView()
                        .padding(.bottom)
                }
                .padding(.horizontal)
                //            .padding(.top, 60)
            }
            
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12.0))
    }
}

struct DailyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            DailyForecastView()
        }
        .padding()
        .background(.blue)
    }
}
