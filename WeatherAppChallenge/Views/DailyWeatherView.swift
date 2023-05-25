//
//  DailyWeatherView.swift
//  WeatherAppChallenge
//
//  Created by Junior on 5/25/23.
//

import SwiftUI

struct DailyWeatherView: View {
    @ObservedObject var cityVM: CityViewViewModel

    var body: some View {
        ForEach(cityVM.weather.daily) { weather in
            LazyVStack {
              NavigationLink(destination: WeatherDetailView(cityVM: self.cityVM)) {
                VStack {
                  dailyCell(weather: weather)
                }
              }
            }
        }
    }

    private func dailyCell(weather: DailyWeather) -> some View {
        HStack {
            Text(cityVM.getDayFor(timestamp: weather.dt).uppercased())
                .frame(width: 50)
            Spacer()

            Text("\(cityVM.getTempFor(temp: weather.temp.max)) | \(cityVM.getTempFor(temp: weather.temp.min)) ℉")
                .frame(width: 150)
            Spacer()

            cityVM.getWeatherIcon(icon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill")
        }
        .foregroundColor(.white)
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
        .background(RoundedRectangle(cornerRadius: 5).fill(LinearGradient(gradient: Gradient(colors: [Color(.blue), Color(.gray), Color(.blue)]), startPoint: .topLeading, endPoint: .bottomTrailing)))
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.white.opacity(0.2), radius: 2, x: 2, y: 2)
    }
}

struct DailyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


