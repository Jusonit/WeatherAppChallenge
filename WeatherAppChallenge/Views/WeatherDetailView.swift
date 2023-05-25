//
//  WeatherDetailView.swift
//  WeatherAppChallenge
//
//  Created by Junior on 5/25/23.
//

import SwiftUI

struct WeatherDetailView: View {
  let cityVM: CityViewViewModel
  var body: some View {
    ScrollView {
      VStack {
        CityNameView(
          city: cityVM.city,
          date: cityVM.date
        )
        .shadow(radius: 0)
        HourlyWeatherView(cityVM: cityVM)
        Spacer()
        TodayWeatherView(cityVM: cityVM)
          .padding()
      }
    }
    .background(LinearGradient(gradient: Gradient(colors: [Color(.blue), Color(.gray)]), startPoint: .topLeading, endPoint: .bottomTrailing))
    .navigationBarTitle("Details", displayMode: .inline)
  }
}
