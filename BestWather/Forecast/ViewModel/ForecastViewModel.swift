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
    
    var city = ""
    var currentForecast: DayForecastViewModel?
    var nextDaysForecast: [DayForecastViewModel] = []
    
    init(forecastService: ForecastService) {
        self.forecastService = forecastService
        refreshWeather()
    }
    
    func refreshWeather() {
        Task {
            guard let weather = await forecastService.getWeather(for: "Warsaw") else {
                return
            }
            
        }
    }
    
}
