//
//  ComponentsFactory.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

final class ComponentsFactory {
    
    private let forecastViewModel = ForecastViewModel()
    private let openWeatherProvider = OpenWeatherProvider(url: "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=7&units=metric&APPID=b933866e6489f58987b2898c89f542b8")
    
    func getForecastViewModel() -> ForecastViewModel {
        forecastViewModel
    }
    
}
