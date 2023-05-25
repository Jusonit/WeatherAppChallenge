//
//  MenuHeaderView.swift
//  WeatherAppChallenge
//
//  Created by Junior on 5/25/23.
//

import SwiftUI

struct MenuHeaderView: View {
    
    //reload in different views
    @ObservedObject var cityVM: CityViewViewModel
    //when state value changes, the view recomputes
    @State private var searchTerm = ""
    
    var body: some View {
        HStack {
          TextField("City Name", text: $searchTerm)
            .padding(.leading, 20)
        
        Button {
            cityVM.city = searchTerm
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color.green)
                Image(systemName: "location.fill")
            }
        }
        .frame(width: 50, height: 50)
    }
        .foregroundColor(.white)
        .padding()
        .background(ZStack (alignment: .leading) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
                .padding(.leading, 10)
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray.opacity(0.5))
            })
        }
}

struct MenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


