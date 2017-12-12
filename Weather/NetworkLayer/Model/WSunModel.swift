//
//  WSunModel.swift
//  Weather
//
//  Created by Iqbal, Aejaz on 12/11/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import Foundation

struct WSunModel {
    
    //Double type, describes the Sunrise time in GMT
    var sunrise :Double
    
    //Double type, describes the Sunset time in GMT
    var sunset :Double
    
    init(sunrise : Double, sunset : Double) {
        
        self.sunrise = sunrise
        
        self.sunset = sunset
    }
    
}
