//
//  WeatherRequestModel.swift
//  Weather
//
//  Created by Aejaz Ahmed KI on 12/11/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

//This model is defined to capture all the request attributes required for making the service call

struct WeatherRequestModel {
   // City for which the temperature needs to be invoked
    var city :String
    
    //Will be used in future to request for Celcisu / F
    var unit :String = "Metric"
    
    //Unique API Key to invoke the session.
    let APIKey:String = "7c8cda3e2ded2febd87b7c4f0678bd53"
    
    init(with city: String)
    {
        self.city = city
    }
}
