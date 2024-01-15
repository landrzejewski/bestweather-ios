//
//  ForecastViewModel.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Foundation
import Observation
import Combine

@Observable
final class ForecastViewModel {

    private let forecastService: ForecastService
    private let locationService: LocationService
    private let mapper: DayForecastViewModelMapper
    private var subscriptions = Set<AnyCancellable>()
    
    var city = ""
    var currentForecast: DayForecastViewModel?
    var nextDaysForecast: [DayForecastViewModel] = []
    
    init(forecastService: ForecastService, locationService: LocationService, mapper: DayForecastViewModelMapper = DayForecastViewModelMapper()) {
        self.forecastService = forecastService
        self.locationService = locationService
        self.mapper = mapper
        locationService.location
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink(receiveValue: onNewCoordinates(coordinates:))
            .store(in: &subscriptions)
        locationService.refreshLocation()
    }
    
    private func onNewCoordinates(coordinates: (Double, Double)) {
        Task {
            guard let weather = await forecastService.getWeather(for: coordinates) else {
                return
            }
            let forecast = mapper.map(forecast: weather.forecast)
            self.city = weather.city
            self.currentForecast = forecast.first
            self.nextDaysForecast = Array(forecast.dropFirst())
        }
    }

}
