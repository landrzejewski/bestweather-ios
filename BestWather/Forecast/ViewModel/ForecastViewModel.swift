//
//  ForecastViewModel.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Observation

@Observable
final class ForecastViewModel {

    private let forecastService: ForecastService
    private let mapper: DayForecastViewModelMapper
    
    var city = ""
    var currentForecast: DayForecastViewModel?
    var nextDaysForecast: [DayForecastViewModel] = []
    
    init(forecastService: ForecastService, mapper: DayForecastViewModelMapper = DayForecastViewModelMapper()) {
        self.forecastService = forecastService
        self.mapper = mapper
        refreshWeather()
    }
    
    func refreshWeather() {
        Task {
            guard let weather = await forecastService.getWeather(for: "Warsaw") else {
                return
            }
            city = weather.city
            let forecast = mapper.map(forecast: weather.forecast)
            currentForecast = forecast.first
            nextDaysForecast = Array(forecast.dropFirst())
        }
    }
    
}
