//
//  HourlyForecastInfoView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI

struct HourlyForecastInfoView: View {
    var body: some View {
        VStack {
            Text("1:00 PM")
                .font(.system(size: 14))
                .fontWeight(.bold)
                .foregroundColor(.white)
            Image(systemName: "sun.max.fill")
                .foregroundColor(.yellow)
                .padding(.vertical, 2)
            Text("23*")
                .font(.system(size: 20))
                .fontWeight(.medium)
                .foregroundColor(.white)
        }
    }
}

struct HourlyForecastInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            HStack(alignment: .center) {
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
            }
        }
        .background(.blue)
    }
}
