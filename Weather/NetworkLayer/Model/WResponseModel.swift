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
    var coordinates : WCordinateModel?
    
    //Maps the weather status to Weather Status Model
    var weatherStatus : WStatusModel?
    
    //Maps the temperature and related details to WeatherResponseModel
    var main : WeatherResponseModel?
    
    //Maps the wind details to wind Model
    var wind : WWindModel?
    
    //Maps the Sun details to SunModel
    var sun : WSunModel?
    
    //String, Maps the city name
    var name :String?
    
    
    /// Initializer of WResponseModel Model
    /// Parameters :
    ///- coordinates : Maps the coordinates to WCoordinateModel
    ///- weather : Maps the weather status to Weather Status Model
    ///-  main : Maps to WeatherResponseModel with temperature and main details
    ///- wind : Maps the wind status to WWindStatus Model
    ///-  sun : Maps to WSun status model and provides sun stats
    ///-  name: Provides the name of the searched city
    
    init(coordinates : WCordinateModel?, weather : WStatusModel?, main : WeatherResponseModel?, wind:WWindModel?, sun : WSunModel?, name : String?) {
        
        self.coordinates = coordinates
        
        self.weatherStatus = weather
        
        self.main = main
        
        self.sun = sun
        
        self.name = name
        
        self.wind = wind
        
    }
}
