//
//  MainView.swift
//  Weather
//
//  Created by Aejaz Ahmed KI on 12/9/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherProtocol :class
{
    func getCurrentWeather(forCity city:String)
    func  getCurrentWeatherImage(withURL : URL, toImage image: FTImageView)
    func showAlert(WithMessage errorMessage:String)
}

class MainView: UIView {

    @IBOutlet weak var citySearchBar: UISearchBar?
    @IBOutlet weak var weatherTableView: UITableView?
    @IBOutlet weak var weatehrImage : FTImageView?
    
    @IBOutlet weak var minValue :UILabel!
    @IBOutlet weak var maxValue :UILabel!
    @IBOutlet weak var pressureValue :UILabel!
    @IBOutlet weak var humidityValue :UILabel!
    @IBOutlet weak var temperatureValue :UILabel!
    
    weak var wetherDelegate : WeatherProtocol?
    
    var weatherViewModel:WeatherViewModel
    
    override init(frame: CGRect) {
        weatherViewModel = WeatherViewModel()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        weatherViewModel = WeatherViewModel()
        super.init(coder: aDecoder)
        
    }
    
    
    
    func setUpMyView() {
       
        citySearchBar?.delegate = self
        
        // Load a temporary image for now, if the
        weatehrImage?.image = UIImage.init(named: "offlineImage")
        
        
        //Call Network Layer to download the image.
        
        //Call ImageView to update the Image in background.
        
        //Relaod the tableView
    }
    
    func updateMyView()
    {
        minValue.text = weatherViewModel.searchResults?.minimumTemperature.toString()
        
        maxValue.text = weatherViewModel.searchResults?.maximumTemperature.toString()
        
        temperatureValue.text = weatherViewModel.searchResults?.temperature.toString()
        
        pressureValue.text = weatherViewModel.searchResults?.pressure.toString()
        
        humidityValue.text = weatherViewModel.searchResults?.humidity.toString()
        
        //Note : Downloading it from Server for a same image type, but will be updated in future.
        
        let imageURL = URL(string: "https://openweathermap.org/img/w/10d.png")
        wetherDelegate?.getCurrentWeatherImage(withURL:imageURL! , toImage: weatehrImage!)
    }
}


extension MainView:UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        searchBar.resignFirstResponder()
    //Make all the Network Layer
    //Future Enhancement : By Default picks up the current location
        guard let searchString = searchBar.text,!searchString.isEmpty else {
         
            //AlertView to display - Please enter a valid string
            wetherDelegate?.showAlert(WithMessage: "Please enter a valid City")
            return
        }
        wetherDelegate?.getCurrentWeather(forCity: searchString)
        PersistentManager.sharedInstance.saveDataToStore(for: ["SearchString":searchString])
    }
}


