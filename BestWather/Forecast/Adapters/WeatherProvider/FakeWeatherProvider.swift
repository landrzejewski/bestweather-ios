//
//  FakeWeatherProvider.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Foundation
import Combine

final class FakeWeatherProvider: WeatherProvider {
    
    func getWeather(for city: String) -> AnyPublisher<Weather, WeatherProviderError> {
        Just(Weather(city: "Warsaw", forecast: [
            DayForecast(id: UUID(), date: Date(), description: "cloudy", temperature: 18.0, pressure: 1000, icon: "cloud.fill"),
            DayForecast(id: UUID(), date: Date(), description: "sunny", temperature: 17.0, pressure: 1001, icon: "sun.max.fill"),
            DayForecast(id: UUID(), date: Date(), description: "heavy rain", temperature: 15.0, pressure: 1002, icon: "cloud.rain.fill"),
            DayForecast(id: UUID(), date: Date(), description: "sunny", temperature: 16.0, pressure: 999, icon: "sun.max.fill"),
            DayForecast(id: UUID(), date: Date(), description: "sunny", temperature: 20.0, pressure: 1000, icon: "sun.max.fill")
        ]))
        .setFailureType(to: WeatherProviderError.self)
        .eraseToAnyPublisher()
    }
    
    func getWeather(for location: (Double, Double)) -> AnyPublisher<Weather, WeatherProviderError> {
        getWeather(for: "")
    }
    
}
