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
    
    init(forecastService: ForecastService) {
        self.forecastService = forecastService
    }
    
    
}
