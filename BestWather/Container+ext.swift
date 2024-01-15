//
//  Container+ext.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Factory

extension Container {
    
    var locationService: Factory<LocationService> {
        self { CoreLocationService() }.singleton
    }
    
    var fakeWeatherProvider: Factory<WeatherProvider> {
        self { FakeWeatherProvider() }.singleton
    }
    
    var openWeatherProvider: Factory<OpenWeatherProvider> {
        self { OpenWeatherProvider(url: "https://api.openweathermap.org/data/2.5/forecast/daily?cnt=7&units=metric&APPID=b933866e6489f58987b2898c89f542b8") }.singleton
    }
    
    var openWeatherProviderAdapter: Factory<WeatherProvider> {
        self { OpenWeatherProviderAdapter(provider: self.openWeatherProvider()) }.singleton
    }
    
    var forecastService: Factory<ForecastService> {
        let proxy = WeatherProviderLoggerProxy(provider: self.openWeatherProviderAdapter())
        return self { ForecastService(weatherProvider: proxy) }.singleton
    }
    
    var forecastViewModel: Factory<ForecastViewModel> {
        self { ForecastViewModel(forecastService: self.forecastService(), locationService: self.locationService()) }.singleton
    }
    
    var fakeForecastViewModel: Factory<ForecastViewModel> {
        let forecastService = ForecastService(weatherProvider: self.fakeWeatherProvider())
        return self { ForecastViewModel(forecastService: forecastService, locationService: self.locationService()) }.singleton
    }
    
}