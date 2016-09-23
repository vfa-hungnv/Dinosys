//
//  Manager.swift
//  Dinosys_Corp_News
//
//  Created by Hung Nguyen on 9/22/16.
//  Copyright © 2016 Hung Nguyen. All rights reserved.
//

import Foundation
class Manager {
    
    var cities: [String: City]?
    
    init () {
        cities = [String: City]()
    }
    
    func addCity(city: City?) {
        if let city = city {
           cities?[city.name] = city
        }
    }
}

extension Manager {

    fileprivate func setDataForFake() -> [City]{
        
        var cities = [City]()
        
        let manchesterImages = ["Manchester1", "Manchester2", "Manchester3", "Manchester4", "Manchester5"]
        let parisImages = ["Paris1", "Paris2", "Paris3", "Paris4", "Paris5"]
        let londonImages = ["London1", "London2", "London3", "London4", "London5"]
        
        
        let eventDescription = ["The theate of dream", "Heart of England tourism", "City of the bay", "The light", "Darkness raise"]
        let eventName = ["Midnight Madness", "Half of Half", "Customer Week Sale", "We Have Again", "Deal of the Century"]
        let citiesName = ["Manchester", "Paris", "London"]
        let citiesDegree = ["-18", "27", "14"]
        
        let citiesImage = [manchesterImages, parisImages, londonImages]
        let date = Date()
        
        for index in 0...cities.count {
            let city: City?
            
            var events = [Event]()
            let eventImages = citiesImage[index]
            for eventIndex in 0...(citiesImage[index].count-1) {
                
                let event = Event(imageName: eventImages[eventIndex], eventName: eventName[eventIndex], discription: eventDescription[eventIndex], time: date, price: "12$")
                events.append(event)
            }
            city = City(name: citiesName[index], degree: citiesDegree[index], events: events)
            if let city = city {
                cities.append(city)
            }
        }
        
        return cities
    }
}

class ManagerFake {
    
    private let manager = Manager()
    
    private init () {
        let cities = manager.setDataForFake()
        for city in cities {
            manager.addCity(city: city)
        }
    }
    
    static let share = ManagerFake().manager
}


