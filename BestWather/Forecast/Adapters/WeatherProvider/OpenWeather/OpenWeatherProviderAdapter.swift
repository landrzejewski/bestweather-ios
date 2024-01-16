//
//  OpenWeatherProviderAdapter.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Foundation
import Combine

final class OpenWeatherProviderAdapter: WeatherProvider {
    
    private let provider: OpenWeatherProvider
    private let mapper: OpenWeatherProviderMapper
    
    init(provider: OpenWeatherProvider, mapper: OpenWeatherProviderMapper = OpenWeatherProviderMapper()) {
        self.provider = provider
        self.mapper = mapper
    }

    func getWeather(for city: String) -> AnyPublisher<Weather, WeatherProviderError> {
        map(provider.getWeather(for: city))
    }
    
    func getWeather(for location: (Double, Double)) -> AnyPublisher<Weather, WeatherProviderError> {
        map(provider.getWeather(for: location))
    }
    
    private func map(_ weatherPublisher: AnyPublisher<WeatherDto, RequestError>) -> AnyPublisher<Weather, WeatherProviderError> {
        weatherPublisher.mapError { _ in WeatherProviderError.forecastRefreshFailed }
            .map { self.mapper.toDomain($0) }
            .eraseToAnyPublisher()
    }
    
}
