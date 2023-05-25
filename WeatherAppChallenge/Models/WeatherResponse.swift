//
//  WeatherResponse.swift
//  WeatherAppChallenge
//
//  Created by Junior on 5/25/23.
//

import Foundation

struct WeatherResponse: Decodable {
    
    var current: Weather
    var hourly: [Weather]
    var daily: [DailyWeather]
    

    //empty state. populate 23 different hours instances, 8 different days instances
    static func empty() -> WeatherResponse {
        return WeatherResponse(current: Weather(), hourly: [Weather](repeating: Weather(), count: 23), daily: [DailyWeather](repeating: DailyWeather(), count: 8))
    }
 
}
