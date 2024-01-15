//
//  WeatherDto.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 15/01/2024.
//

import Foundation

struct WeatherDto: Codable {
    
    let city: CityDto
    let forecast: [ForecastDto]
    
    enum CodingKeys: String, CodingKey {
     
        case city
        case forecast = "list"
        
    }
    
}
