//
//  ForecastComponentsFactory.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Foundation

final class ForecastComponentsFactory {
    
    private let locationService: LocationService
    
    private let fakeWeatherProvider = FakeWeatherProvider()
 
    private let openWeatherProvider = OpenWeatherProvider(url: "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=7&units=metric&APPID=b933866e6489f58987b2898c89f542b8")
    
    private lazy var openWeatherProviderAdapter = OpenWeatherProviderAdapter(provider: openWeatherProvider)
    
    private lazy var forecastService = ForecastService(weatherProvider: WeatherProviderLoggerProxy(provider: openWeatherProviderAdapter))
    
    private lazy var forecastViewModel = ForecastViewModel(forecastService: forecastService, locationService: locationService)
    
    func getForecastViewModel() -> ForecastViewModel {
        forecastViewModel
    }
    
    func getPreviewForecastViewModel() -> ForecastViewModel {
        ForecastViewModel(forecastService: ForecastService(weatherProvider: fakeWeatherProvider), locationService: locationService)
    }
    
    init(locationService: LocationService) {
        self.locationService = locationService
    }
    
}
