//
//  WeatherService.swift
//  Weather
//
//  Created by Aejaz Ahmed KI on 12/9/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import Foundation

// This class handles all the service call invocations and error handloing mechanisms

//Creating a typeAlias to parese the response received as key value pairs
typealias JSONDictionary = [String:Any]

class WeatherService
{
    
    //Error Message to disply error
    var  errorMessage = ""
    
    func invokeWeatherService (withRequestModel requestModel: WeatherRequestModel, completion:@escaping(Dictionary<String,Any>,String)->Void)
    {
        //Create a default session
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        
        // Create a data task for the session
        var dataTask: URLSessionDataTask?
        
        //Cancel the previous task if executing
        dataTask?.cancel()
        
        //Build the URL Components for making the request
        if var urlComponents = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather") {
            urlComponents.query = "q=\(requestModel.city)&appid=\(requestModel.APIKey)&mode=json&units=\(requestModel.unit)"
            
            //IF the component is not build properly, exit
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer {dataTask = nil }
                var responseDic :Dictionary<String,Any>?
                if let error = error {
                    //Data Task Error, Should be moved to a seperate NSError class to handle all types of error
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data {
                    
                    guard let response = response as? HTTPURLResponse, response.statusCode==200 else
                    {
                        self.errorMessage += " Some Error in HTTP Response"
                        return;
                    }
                        print(response)
                    //Serialize the data elements
                     responseDic = self.serializeResult(data)
                    
                }
                DispatchQueue.main.async {
                    //Update the UI on main thread
                    completion(responseDic!, self.errorMessage)
                }
            }
            
            dataTask?.resume()
        }
        
    }
    
    fileprivate func serializeResult(_ data: Data)-> Dictionary<String,Any>?{
        var response: JSONDictionary?
        
        do
        {
            // Parsing the Response Object using JSON Serialization
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            //Error Durimng JSON Parsing, this will be moved to a seperate class for error handling
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return nil
        }
        
        guard let respons = response,!(respons.isEmpty) else {
            //Response is Empty 
            errorMessage += "Dictionary does not contain results key\n"
            return nil
        }
        
        return response
    }
}


