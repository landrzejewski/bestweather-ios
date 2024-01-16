//
//  WeatherProviderLoggerProxy.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Foundation
import Combine

final class WeatherProviderLoggerProxy: WeatherProvider {
   
    private let provider: WeatherProvider
    
    init(provider: WeatherProvider) {
        self.provider = provider
    }
    
    func getWeather(for city: String) -> AnyPublisher<Weather, WeatherProviderError> {
        print("Fetching weather for city \(city)")
        return provider.getWeather(for: city)
    }
    
    func getWeather(for location: (Double, Double)) -> AnyPublisher<Weather, WeatherProviderError> {
        print("Fetching weather for location \(location)")
        return provider.getWeather(for: location)
    }
    
}
