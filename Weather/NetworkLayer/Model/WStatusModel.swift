//
//  WStatusModel.swift
//  Weather
//
//  Created by Iqbal, Aejaz on 12/11/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import Foundation

struct WStatusModel{

    //is a type of double, describes the unique id of the searched city
    var id : Double
    
    //String type, describes the current weather status - eg. Drizzle
    var main : String
    
    //String type, describes the current status, eg. Light drizzle in newyork
    var description:String
    
    //String type, provides URL for the current weather state icon
    var icon :String
    
    init(id:Double, main:String, description:String, icon:String) {
    
        self.id = id
        
        self.main = main
        
        self.description = description
        
        self.icon = icon
        
    }
}
