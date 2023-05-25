//
//  CityViewViewModel.swift
//  WeatherAppChallenge
//
//  Created by Junior on 5/25/23.
//

import Foundation
import SwiftUI
import CoreLocation

//observe changes when they happen
final class CityViewViewModel: ObservableObject {
    
    //observable object - announced when changed
    @Published var weather = WeatherResponse.empty()
    @Published var city: String = "" {
        didSet {
            getLocation()
        }
    }
    //initial value is not calculated until first time called
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE" //3 letter day
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    
    init() {
        getLocation()
    }
    
    var date: String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.current.dt)))
    }
    
    var weatherIcon: String {
        //successful api calls will have count > 0
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].icon
        }
        return "clearNightSky"
    }
    
    var temperature: String {
        return getTempFor(temp: weather.current.temp)
    }
    
    var conditions: String {
        if weather.current.weather.count > 0 {
            return weather.current.weather[0].main
            //main : clear, cloudy, etc...
        }
        return ""
    }
    
    var windSpeed: String {
        return String(format: "%0.1f", weather.current.wind_speed)
    }
    
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity) //integer
    }
    
    var rainChances: String {
        return String(format: "%0.0f", weather.current.dew_point)
    }
    
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    //placemarks : collection of places in an area
    private func getLocation() {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks, let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let urlString = API.getURLFor(lat: coord.latitude, lon: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
        }
        else {
            //default coordinates
            let urlString = API.getURLFor(lat: 39.50, lon: -120.90)
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
    //network call
    private func getWeatherInternal(city: String, for urlString: String) {
        NetworkManager<WeatherResponse>.fetch(for: URL(string: urlString)!) { (result) in
            switch result {
                
                case .success(let response):
                    DispatchQueue.main.async {
                        self.weather = response
                    }
                    
                case .failure(let err):
                    print(err)
            }
        }
    }
    
    //1:17
    func getAnimationFor(icon: String) -> String {
        switch icon {
        case "01d":
            return "dayFewClouds"
        case "01n":
            return "nightMist"
        default:
            return "dayRains"
        }
    }
    
    func getWeatherIcon(icon: String) -> Image {
        switch icon {
        case "01d":
            return Image(systemName: "sun.max.fill")
        case "01n":
            return Image(systemName: "moon.fill")
        default:
            return Image(systemName: "cloud.sun.fill")
        }
    }
    
}
