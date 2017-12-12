//
//  ResponseParser.swift
//  Weather
//
//  Created by Aejaz Ahmed KI on 12/11/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import Foundation

//Sample Response

/*
 
 {"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":300,"main":"Drizzle","description":"light intensity drizzle","icon":"09d"}],"base":"stations","main":{"temp":280.32,"pressure":1012,"humidity":81,"temp_min":279.15,"temp_max":281.15},"visibility":10000,"wind":{"speed":4.1,"deg":80},"clouds":{"all":90},"dt":1485789600,"sys":{"type":1,"id":5091,"message":0.0103,"country":"GB","sunrise":1485762037,"sunset":1485794875},"id":2643743,"name":"London","cod":200}
 
 */


final class ResponseParser{
    
    //Parses the Coordinates from the coordinates array in response
    static func parseCoordinateResponseModel (jsonDict: JSONDictionary) -> WCordinateModel?
    {
        //Check if the response dictionary is empty while converting
        guard let jsonDict = jsonDict as? Dictionary<String, Double>, !jsonDict.isEmpty else {
            
            print("Error : No Coordinate Received")
            return nil
            
        }
       
         //is a type of double, describes the latitude, longitude of the searched city
        //There is no point in parsing either one of latitude or longitude, so use Guard
        guard let latitude  = jsonDict [responeParser.latitude.rawValue], let longitude = jsonDict [responeParser.longitude.rawValue]  else
        {
            print("Error : Parsing : Coordinates")
            return nil
            
        }
       // Generates the model - WCoordinateModel and returns it back to response
        let respCordinateModel = WCordinateModel.init(lat: latitude, long: longitude)
        
        return respCordinateModel
        
    }
    
    //Parses the Main WeatherResponseModel from the Weather array in response
    static func parseMainWeatherResponseModel (jsonDict: JSONDictionary) -> WeatherResponseModel?
    {
        //Check if the response dictionary is empty while converting
        guard let jsonDict = jsonDict as? Dictionary<String, Double>, !jsonDict.isEmpty else {
            
            print("Error : No Main Weather Response Received")
            return nil
            
        }
        
        //is a type of double, describes the temperature, minimumTemp,maxTemp, pressure, humidity of the searched cit
        // Generates the model - WeatherResponseModel and returns it back to response
        // Service May not return 1 or more response, parse it individually. All properties are optional
        
        let respCordinateModel = WeatherResponseModel.init(
                                                            temperature:jsonDict[responeParser.temperature.rawValue],
                                                            pressure:jsonDict[responeParser.pressure.rawValue],
                                                            humidity: jsonDict[responeParser.humidity.rawValue],
                                                            maximumTemperature: jsonDict[responeParser.temperatureMax.rawValue],
                                                            minimumTemperature: jsonDict[responeParser.temperatureMin.rawValue])
        
        return respCordinateModel
        
    }
    
    //Parses the WindResponseModel from the Wind array in response
    static func parseWindResponseModel (jsonDict: JSONDictionary) -> WWindModel?
    {
        //Check if the response dictionary is empty while converting
        guard let jsonDict = jsonDict as? Dictionary<String, Double>, !jsonDict.isEmpty else {
            print("Error : No Wind Response Received")
            return nil
        }
        
        //is a type of double, describes the speed and humidity of wind in the searched cit
        // Generates the model - WWindModel and returns it back to response
        // Service May not return 1 or more response, parse it individually. All properties are optional
        
        let respCordinateModel = WWindModel.init(speed: jsonDict[responeParser.speed.rawValue],
                                                 degree: jsonDict[responeParser.degree.rawValue])
        
        return respCordinateModel
        
    }
    
    //Parses the WindResponseModel from the Wind array in response
    static func parseSunResponseModel (jsonDict: JSONDictionary) -> WSunModel?
    {
        //Check if the response dictionary is empty while converting
        guard !jsonDict.isEmpty else {
            print("Error : No Sun Response Model Received")
            return nil
        }
        
        //is a type of double, describes the speed and humidity of wind in the searched cit
        // Generates the model - WWindModel and returns it back to response
        // Service May not return 1 or more response, parse it individually. All properties are optional
        
        let respCordinateModel = WSunModel.init(sunrise: jsonDict[responeParser.sunrise.rawValue] as? Double,
                                                sunset: jsonDict[responeParser.sunset.rawValue] as? Double )
        
        return respCordinateModel
        
    }
    
    //Parses the WeatherStatus from the coordinates array in response
    static func parseWeatherStatusResponseModel (jsonDict: Array<JSONDictionary>) -> WStatusModel?
    {
        //Check if the response dictionary is empty while converting
        guard !jsonDict.isEmpty else {
            print("Error : No Weather Status Received")
            return nil
        }
        
        //is a type of double, describes the id, description, main and icon of the searched city
        //The array
        guard
              let dictObj = jsonDict[0] as? JSONDictionary,
              let id  = dictObj [responeParser.id.rawValue] as? Double,
              let desc = dictObj [responeParser.description.rawValue] as? String,
              let main = dictObj [responeParser.main.rawValue] as? String,
              let icon = dictObj [responeParser.icon.rawValue] as? String
            else
        {
            print("Error : Parsing : Coordinates")
            return nil
        }
        // Generates the model - WStatusModel and returns it back to response
        let respCordinateModel = WStatusModel.init(id: id, main: main, description: desc, icon: icon)
        
        return respCordinateModel
        
    }
    
    static func parseWeatherResponseModel (jsonDict: JSONDictionary) -> WResponseModel?
    {
        guard  !jsonDict.isEmpty else {
            print("Dictionary is Empty, Empty Response Received")
            return nil
        }
        
        print("Received Response \(jsonDict.values)");
        
        // Maps the coordinates to WCoordinateModel
        let coordinates : WCordinateModel? = parseCoordinateResponseModel(jsonDict: jsonDict[responeParser.coordinate.rawValue] as! JSONDictionary)
        
        //Maps the weather status to Weather Status Model
        let weather : WStatusModel? = parseWeatherStatusResponseModel(jsonDict: jsonDict[responeParser.weather.rawValue] as! Array<JSONDictionary>)
        
        //Maps the temperature and related details to WeatherResponseModel
        let main : WeatherResponseModel? = parseMainWeatherResponseModel(jsonDict: jsonDict[responeParser.main.rawValue] as! JSONDictionary)
        
        //Maps the wind details to wind Model
        let wind : WWindModel? = parseWindResponseModel(jsonDict: jsonDict[responeParser.wind.rawValue] as! JSONDictionary)
        
        let sunDict : JSONDictionary = jsonDict[responeParser.system.rawValue] as! JSONDictionary
        
        //Maps the Sun details to SunModel
        let sun : WSunModel? = parseSunResponseModel(jsonDict:sunDict as! JSONDictionary)
        
        //String, Maps the city name
        let name :String? = jsonDict[responeParser.name.rawValue] as? String
        
        let responseModel = WResponseModel.init(coordinates: coordinates, weather: weather, main: main, wind: wind, sun: sun, name: name)
        
        return responseModel
        
    }
    
}
