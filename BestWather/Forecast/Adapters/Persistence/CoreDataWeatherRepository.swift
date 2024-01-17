//
//  CoreDataWeatherRepository.swift
//  BestWather
//
//  Created by Łukasz Andrzejewski on 17/01/2024.
//

import Foundation
import CoreData

final class CoreDataWeatherRepository: WeatherRepository {
    
    private let persistence: Persistence
    
    init(persistence: Persistence) {
        self.persistence = persistence
    }
   
    func save(weather: Weather) throws {
        let team = NSEntityDescription.insertNewObject(forEntityName: "ForecastEntity", into: persistence.context()) as! ForecastEntity
    }
    
    func deleteAll() throws {
        
    }
    
    func get(by city: String, callback: @escaping (Result<Weather, WeatherRepositoryError>) -> ()) {
        
    }
    
}
