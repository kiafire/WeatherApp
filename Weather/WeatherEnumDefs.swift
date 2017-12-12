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
    case latitude = "lat"
    case longitude = "lon"
    
    case id
    case main
    case description
    case icon
    
    case sunrise
    case sunset
    
    case speed
    case degree = "deg"
    
    case temperature = "temp"
    case humidity
    case pressure
    case temperatureMax = "temp_max"
    case temperatureMin = "temp_min"
    
    
}
