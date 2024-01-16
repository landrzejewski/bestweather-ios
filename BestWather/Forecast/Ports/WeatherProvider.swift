//
//  WeatherProvider.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Combine

protocol WeatherProvider {
    
    func getWeather(for city: String) -> AnyPublisher<Weather, WeatherProviderError>
    
    func getWeather(for location: (Double, Double)) -> AnyPublisher<Weather, WeatherProviderError>
    
}
