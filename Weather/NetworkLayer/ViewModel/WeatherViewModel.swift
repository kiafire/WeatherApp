//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Aejaz Ahmed KI on 12/9/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import Foundation
import UIKit

class WeatherViewModel {
   
    //Request Model
    var searchModel :WeatherRequestModel?
    
    //Response Model
    var searchResults:WeatherResponseModel?
    
    //TypeAlias for a expected prsing pattern
    typealias JSONDictionary = [String: Any]
    
    //Error Message
    var errorMessage :String = ""
    
    //Initialize the service manager
    var service = WeatherService()
    
    var searchString : String {
     
        //Get the search String from the request model, update it to return the complete Query required With Search City and Metrics used
        if let searchstr = searchModel?.city {
            return searchstr
        }
        
        return ""
    }
    var entity : String{
      
        if let searchApi = searchModel?.APIKey {
            return searchApi
        }
        return ""
    }
    
    public init(){
    
    }
}

 extension WeatherViewModel{
    
    func setSearchString(searchString:String){
       //If Model is unavailable create a new one
        guard let model = searchModel else {
            searchModel = WeatherRequestModel(with: searchString)
            return
        }
        searchModel?.city = searchString
    }
    
    func setEntityUnit (entityUnit:String){
        
     /*   guard let model = searchModel else {
            searchModel = WeatherRequestModel(with: searchString)
            return
        }*/
        searchModel?.unit = entityUnit
    }
    
    func invokeWeatherService(completion:@escaping(WeatherResponseModel,String)->())
    {
       
        service.invokeWeatherService(withRequestModel: searchModel!) { resultsDic, errorMessage in

    
            guard let rArray = resultsDic["main"] as? JSONDictionary else {
                self.errorMessage += "Dictionary does not contain required keys\n"
                return
            }
            
            //var wResModel = WeatherResponseModel()
           

            var searchResult = WeatherResponseModel()
            
            for res in (rArray as? Dictionary<String,Double>)! {
                
                switch(res.key)
                {
                    case "humidity":
                        searchResult.humidity = res.value
                    case "temp_min":
                         searchResult.minimumTemperature  = res.value
                    case "temp_max":
                         searchResult.maximumTemperature = res.value
                    case "temp":
                        searchResult.temperature = res.value
                    case "pressure":
                        searchResult.pressure = res.value
                    default:
                    print("Other Elements - Not interested for now")
                }
               
            }
           self.searchResults = searchResult

            DispatchQueue.main.async {
                completion(self.searchResults!, self.errorMessage)
            }
        }
        
    }
    
}
