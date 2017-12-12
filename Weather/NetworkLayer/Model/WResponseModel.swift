//
//  WResponseModel.swift
//  Weather
//
//  Created by Iqbal, Aejaz on 12/11/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import Foundation

struct WResponseModel {

    // Maps the coordinates to WCoordinateModel
    var coordinates : WCordinateModel
    
    //Maps the weather status to Weather Status Model
    var weather : WStatusModel
    
    //Maps the temperature and related details to WeatherResponseModel
    var main : WeatherResponseModel
    
    //Maps the wind details to wind Model
    var wind : WWindModel
    
    //Maps the Sun details to SunModel
    var sun : WSunModel
    
    //String, Maps the city name
    var name :String
    
    init(coordinates : WCordinateModel, weather : WStatusModel, main : WeatherResponseModel, wind:WWindModel, sun : WSunModel, name : String) {
        
        self.coordinates = coordinates
        
        self.weather = weather
        
        self.main = main
        
        self.sun = sun
        
        self.name = name
        
        self.wind = wind
        
    }
}
