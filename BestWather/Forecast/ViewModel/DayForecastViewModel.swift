//
//  DayForecastViewModel.swift
//  Best Weather
//
//  Created by Łukasz Andrzejewski on 19/11/2023.
//

import Foundation

struct DayForecastViewModel: Identifiable {
    
    let id: UUID
    let date: String
    let description: String
    let temperature: String
    let pressure: String
    let icon: String
    
}
