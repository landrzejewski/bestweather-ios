//
//  OpenApiWeatherProvider.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Foundation

final class WeatherProvider {
    
    private let url = "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=7&units=metric&APPID=b933866e6489f58987b2898c89f542b8"
    private let decoder = JSONDecoder()
    
    func getWeather(for city: String) async -> WeatherDto? {
        guard let url = URL(string: "\(url)&q=\(city)") else {
            return nil
        }
        return await getWeather(url: url)
    }
    
    func getWeather(for location: (Double, Double)) async -> WeatherDto? {
        guard let url = URL(string: "\(url)&lon=\(location.0)&lat=\(location.1)") else {
            return nil
        }
        return await getWeather(url: url)
    }
    
    private func getWeather(url: URL) async -> WeatherDto? {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try decoder.decode(WeatherDto.self, from: data)
        } catch {
            return nil
        }
    }
    
}
