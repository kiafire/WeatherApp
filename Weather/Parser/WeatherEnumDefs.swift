//
//  WeatherEnumDefs.swift
//  Weather
//
//  Created by Aejaz Ahmed KI on 12/11/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import UIKit

enum responeParser : String
{
    case coordinate = "coord"
    case latitude = "lat"
    case longitude = "lon"
    
    case weather
    case id
    case main
    case description
    case icon
    
    case system = "sys"
    case sunrise
    case sunset
    
    case wind
    case speed
    case degree = "deg"
    
    case temperature = "temp"
    case humidity
    case pressure
    case temperatureMax = "temp_max"
    case temperatureMin = "temp_min"
    
    case name
    
    
}
