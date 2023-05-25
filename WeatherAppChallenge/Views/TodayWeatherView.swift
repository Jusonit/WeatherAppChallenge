//
//  TodayWeatherView.swift
//  WeatherAppChallenge
//
//  Created by Junior on 5/25/23.
//

import SwiftUI

struct TodayWeatherView: View {
    
    @ObservedObject var cityVM: CityViewViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Today")
                .font(.largeTitle)
                .bold()
            
            HStack(spacing: 20) {
                LottieView(name: cityVM.getAnimationFor(icon: cityVM.weatherIcon))
                    .frame(width: 100, height: 150)
                
                VStack(alignment: .leading) {
                    Text("\(cityVM.temperature)℉")
                        .font(.system(size: 42))
                    Text(cityVM.conditions)
                }
            }
            HStack {
                Spacer()
                widgetView(image: "drop.fill", color: .blue, title: "Humidity\n\(cityVM.humidity)")
                Spacer()
                widgetView(image: "umbrella.fill", color: .purple, title: "Rain Chance\n\(cityVM.rainChances)")
                Spacer()
                widgetView(image: "wind", color: .green, title: "Wind Speed\n\(cityVM.windSpeed)mi/hr")
                Spacer()
                
                
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)).opacity(0.3))
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.white.opacity(0.2), radius: 2, x: 2, y: 2)
    }
    
    private func widgetView(image: String, color: Color, title: String) -> some View {
        VStack {
            Image(systemName: image)
                .padding()
                .font(.title)
                .foregroundColor(color)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            
            Text(title)
        }
    }
}

struct TodayWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

