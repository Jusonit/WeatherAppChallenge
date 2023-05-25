//
//  ContentView.swift
//  WeatherAppChallenge
//
//  Created by Junior on 5/25/23.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var cityVM = CityViewViewModel()
  var body: some View {
    NavigationView {
      ZStack(alignment: .bottom) {
        VStack(spacing: 0) {
          MenuHeaderView(cityVM: cityVM).padding()
          ScrollView(showsIndicators: false) {
            CityView(cityVM: cityVM)
          }.padding(.top, 10)
        }
        .background(
          LinearGradient(
            gradient: Gradient(
              colors: [Color(.blue), Color(.gray)]
            ),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
        )
      }
      .navigationBarTitle("", displayMode: .inline)
      .navigationBarHidden(true)
      .foregroundColor(.orange)
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
