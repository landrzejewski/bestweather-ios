//
//  FakeWeatherProvider.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Foundation

final class FakeWeatherProvider: WeatherProvider {
   
    func getWeather(for city: String) async -> Weather? {
        Weather(city: "Warsaw", forecast: [
            DayForecast(id: UUID(), date: Date(), description: "cloudy", temperature: 18.0, pressure: 1000, icon: "sun.max.fill")
        ])
    }
    
    func getWeather(for location: (Double, Double)) async -> Weather? {
        nil
    }
    
}
