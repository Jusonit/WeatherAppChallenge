//
//  CityView.swift
//  WeatherAppChallenge
//
//  Created by Junior on 5/25/23.
//

import SwiftUI

struct CityView: View {
  @ObservedObject var cityVM: CityViewViewModel
  
  var body: some View {
    VStack {
      DailyWeatherView(cityVM: cityVM)
    }
    .padding(.bottom, 30)
  }
}

struct CityView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

