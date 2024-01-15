//
//  ForecastService.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Foundation

final class ForecastService {
    
    private let weatherProvider: WeatherProvider
    
    init(weatherProvider: WeatherProvider) {
        self.weatherProvider = weatherProvider
    }
    
    func getWeather(for city: String) async -> Weather? {
        await weatherProvider.getWeather(for: city)
        // dodatkowa logika np. filtrowanie
    }
    
    func getWeather(for location: (Double, Double)) async -> Weather? {
        await weatherProvider.getWeather(for: location)
    }
    
}
