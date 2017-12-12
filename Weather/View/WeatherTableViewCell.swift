//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Aejaz Ahmed KI on 12/12/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import UIKit

class  WeatherTableViewCell: UITableViewCell {
    
    // This is a custom Cell to display Key Value pairs on Weather Table
    // Key : Temeperatyre, Humidity Etc
    //Value : The relevant Values fetched.
    // All Properties are customized on story board.
    
    @IBOutlet weak var keyLabel : UILabel!
    
    @IBOutlet weak var valueLabel : UILabel!
}
