//
//  ComponentsFactory.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Foundation

final class ComponentsFactory {
    
    private let forecastViewModel: ForecastViewModel
    
    init() {
        forecastViewModel = ForecastViewModel()
    }
    
    func getForecastViewModel() -> ForecastViewModel {
        forecastViewModel
    }
    
}
