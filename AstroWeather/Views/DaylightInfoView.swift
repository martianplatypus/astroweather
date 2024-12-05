//
//  DaylightInfoView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI

struct DaylightInfoView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "sunset.fill")
                    .foregroundColor(.white.opacity(0.6))
                Text("Sunset".uppercased())
                    .font(.system(size: 12))
                    .fontWeight(.medium)
                    .foregroundColor(.white.opacity(0.6))
            }
            Text("6:45 PM")
                .font(.system(size: 36))
                .fontWeight(.regular)
                .foregroundColor(.white)
            Spacer()
            Text("Sunrise: 5:34 AM")
                .font(.system(size: 12))
                .fontWeight(.regular)
                .foregroundColor(.white)
        }
        .padding()
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12.0))
    }
}

struct DaylightInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            HStack {
                Spacer()
                DaylightInfoView()
                Spacer()
            }
            .padding(.top, 60)
        }
        .background(.blue)
    }
}
