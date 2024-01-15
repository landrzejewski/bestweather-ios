//
//  ComponentsFactory.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

final class ComponentsFactory {
    
    private let locationService: LocationService = CoreLocationService()
    
    lazy var forecastFactory = ForecastComponentsFactory(locationService: locationService)
    
}
