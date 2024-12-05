//
//  WeatherInfoTileView.swift
//  AstroWeather
//
//  Created by Luiz Rath on 12/4/24.
//

import SwiftUI

struct WeatherInfoTileView: View {
    @StateObject var viewModel: WeatherInfoTileViewModel = WeatherInfoTileViewModel()
    
    var body: some View {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: viewModel.iconName ?? "")
                            .foregroundColor(.white.opacity(0.6))
                        Text(viewModel.title.uppercased())
                            .font(.system(size: 12))
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Text(viewModel.info)
                        .font(.system(size: 32))
                        .fontWeight(.light)
                        .foregroundColor(.white)
                }
                .padding()
                .frame(maxWidth: .infinity, minHeight: 100)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12.0))
            }
}

final class WeatherInfoTileViewModel: ObservableObject {
    @Published var iconName: String?
    @Published var title: String
    @Published var info: String
    @Published var caption: String
    
    init(iconName: String? = nil, title: String = "", info: String = "", caption: String = "") {
        self.iconName = iconName
        self.title = title
        self.info = info
        self.caption = caption
    }
}

extension WeatherInfoTileViewModel: ViewModelMockable {
    
    static func mock() -> WeatherInfoTileViewModel {
        let mock = WeatherInfoTileViewModel()
        mock.iconName = "triangle.fill"
        mock.title = "Triangle"
        mock.info = "Cool"
        mock.caption = ""
        return mock
    }
    
    
}

struct WeatherInfoTileView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            HStack {
                WeatherInfoTileView(viewModel: WeatherInfoTileViewModel.mock())
                WeatherInfoTileView(viewModel: WeatherInfoTileViewModel.mock())
            }
        }
        .padding()
        .background(.blue)
    }
}
