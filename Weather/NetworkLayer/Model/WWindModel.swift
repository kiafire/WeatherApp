//
//  WWindModel.swift
//  Weather
//
//  Created by Iqbal, Aejaz on 12/11/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import Foundation

struct WWindModel {
    
    //Double type, describes the speed of the cloud movement
    var speed : Double?
    
    //Double type, describes the degree of the cloud mpvement
    var degree :Double?
 
    init(speed : Double?, degree: Double?) {
        
        self.speed = speed
        
        self.degree = degree
    }
}
