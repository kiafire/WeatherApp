//
//  WeatherEnumDefs.swift
//  Weather
//
//  Created by Aejaz Ahmed KI on 12/11/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import UIKit

// This Enum will be used to Parse data from JSON Dictionary,
//. This is a helper class to Response Parser
//  Raw Value is updated for keys whose response keys are logically not meaningful
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
    case some
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
