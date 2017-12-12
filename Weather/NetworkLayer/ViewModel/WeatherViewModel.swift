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
    var searchResults:WResponseModel?
    
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
        guard searchModel != nil else {
            searchModel = WeatherRequestModel(with: searchString)
            return
        }
        searchModel?.city = searchString
    }
    
    func setEntityUnit (entityUnit:String){
        
        //If Model is unavailable create a new one
        guard searchModel != nil else {
            searchModel = WeatherRequestModel(with: searchString)
            return
        }
        searchModel?.unit = entityUnit
    }
    
    func invokeWeatherService(completion:@escaping(WResponseModel,String)->())
    {
       
        service.invokeWeatherService(withRequestModel: searchModel!) { resultsDic, errorMessage in

            // Validate if results dict is empty, May happend when the JSON Serialization is buggy.
            
            guard !resultsDic.isEmpty else {
                self.errorMessage += "Dictionary does not contain required keys\n"
                return
            }
            
            //Invoke the P:arser to parse the JSON Dict to Objects
            let searchResult = ResponseParser.parseWeatherResponseModel(jsonDict: resultsDic)

            self.searchResults = searchResult
           
            //Update the UI on main thread
            DispatchQueue.main.async {
                completion(self.searchResults!, self.errorMessage)
            }
        }
        
    }
    
}
