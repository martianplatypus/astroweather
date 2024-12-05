//
//  DailyForecastRowView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI

struct DailyForecastRowView: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .bottom) {
                Text("Today")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.trailing)
                Spacer()
                VStack(alignment: .center) {
                    Image(systemName: "cloud.rain.fill")
                        .foregroundColor(.white)
                    Text("70%")
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 95/255, green: 198/255, blue: 237/255))
                }
                Spacer()
                Text("L: 19")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .opacity(0.6)
                Spacer()
                Text("H: 23")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
            }
            .padding(.vertical, 2)
        }
    }
}

struct DailyForecastRowView_Previews: PreviewProvider {
    static var previews: some View {
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
            }
            .padding(.horizontal)
        }
        .padding()
        .background(.blue)
    }
}
