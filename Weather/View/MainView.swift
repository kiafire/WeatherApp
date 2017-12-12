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
    func  getCurrentWeatherImage(withURL : URL?, toImage image: FTImageView)
    func showAlert(WithMessage errorMessage:String)
}

class MainView: UIView {

    //IBOutlets for Main View UI Storyboard elements. //
   
    @IBOutlet weak var citySearchBar: UISearchBar?
    
    @IBOutlet weak var weatherTableView: UITableView?
    
    @IBOutlet weak var weatehrImage : FTImageView?
    
    @IBOutlet weak var cityName :UILabel!
    
    @IBOutlet weak var weatherDesc :UILabel!
    
    // Delegate to handle  fetching data
    
    weak var wetherDelegate : WeatherProtocol?
    
    //View Model manipulates the data for display.
    var weatherViewModel:WeatherViewModel
    
    override init(frame: CGRect) {
        weatherViewModel = WeatherViewModel()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        weatherViewModel = WeatherViewModel()
        super.init(coder: aDecoder)
        
    }
    
    // Preliminary setup of ViewDisplay
    
    func setUpMyView() {
       
        citySearchBar?.delegate = self
       
        weatherTableView?.backgroundColor = UIColor.clear
        // Load a temporary image for now, if the
       // weatehrImage?.image = UIImage.init(named: "downloadImg")
        
        
        //Call Network Layer to download the image.
        
        //Call ImageView to update the Image in background.
        
        //Relaod the tableView
    }
    
    func updateMyView()
    {
     
        //Reload the tableView to Update the Data
        weatherTableView?.reloadData()
        
        //Update the City
        cityName.text = weatherViewModel.searchResults?.name
        
        //Update the description
        weatherDesc.text = weatherViewModel.searchResults?.weatherStatus?.description
        
        //Start Loading the Image Icon
       if let imageIcon = weatherViewModel.searchResults?.weatherStatus?.icon
       {
        //Build the URL Query Parameter
        let urlString = "https://openweathermap.org/img/w/\(imageIcon).png"
        
        //Fetch the Image Icon through the delegate
        wetherDelegate?.getCurrentWeatherImage(withURL:URL(string:urlString)! , toImage: weatehrImage!)
        }
    }
}

//Mark SearchBar Delegates

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
        
        //Fetch the current weather for the searched city
        wetherDelegate?.getCurrentWeather(forCity: searchString)
        
        //Store the searched String to presistent storage so as to retrive in the next app launch
        PersistentManager.sharedInstance.saveDataToStore(for: ["SearchString":searchString])
    }
}

//MArk TableView Delegates

extension MainView : UITableViewDataSource
{
    //Display Rows Enum determines which values needs to be displayed to the end user
    //It also handles the order of the display.
    
    enum wDisplayRows :Int
    {
        case temperature
        case pressure
        case humidity
        case temperatureMax
        case temperatureMin
        case sunrise
        case sunset
        case degree
        case speed
        
        //to identify the total count , get the last value and add one - Note In Swift case start with zero
        static var count: Int { return wDisplayRows.speed.hashValue + 1}
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Number of rows to display is controlled by wDisplayEnums
        return wDisplayRows.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        if let row = wDisplayRows.init(rawValue: indexPath.row)
        {
            cell.backgroundColor = UIColor.clear
           
            //This switch should be exhaustive - Must represent all the cases in the wDisplayRows Enum
            switch row
            {
            case .degree:
               
                // Read the Wind Object from Response, convert to string and append degree.
                cell.valueLabel?.text = "\(weatherViewModel.searchResults?.wind?.degree?.toString() ?? "-") \u{00B0}"
                
                cell.keyLabel?.text =  "Wind \(wDisplayRows.degree)".capitalized(with: nil)
            
            case .humidity:
                
                 // Read the Main Object from Response and append %.
                cell.valueLabel?.text = "\(weatherViewModel.searchResults?.main?.humidity?.toInt() ?? 0)%"
                
                cell.keyLabel?.text =  "\(wDisplayRows.humidity)".capitalized(with: nil)
            
            case .pressure:
                
                 // Read the Main Object from Response, convert to string and append inHg.
                cell.valueLabel?.text = "\(weatherViewModel.searchResults?.main?.pressure?.toInt() ?? 0) inHg"
                
                cell.keyLabel?.text =  "\(wDisplayRows.pressure)".capitalized(with: nil)
            
            case .temperature:
                
                 // Read the Main Object from Response, convert to string and append degree.
                cell.valueLabel?.text = "\(weatherViewModel.searchResults?.main?.temperature?.toString() ?? "-") \u{00B0}"
                
                cell.keyLabel?.text =  "\(wDisplayRows.temperature)".capitalized(with: nil)
            
            case .temperatureMax:
                
                 // Read the Main Object from Response, convert to string and append degree.
                cell.valueLabel?.text = "\(weatherViewModel.searchResults?.main?.maximumTemperature?.toString() ?? "-") \u{00B0}"
                
                cell.keyLabel?.text =  "\(wDisplayRows.temperatureMax)".capitalized(with: nil)
            
            case .temperatureMin:
                
                 // Read the Main Object from Response, convert to string and append degree.
                cell.valueLabel?.text = "\(weatherViewModel.searchResults?.main?.minimumTemperature?.toString() ?? "-" ) \u{00B0}"
                
                cell.keyLabel?.text =  "\(wDisplayRows.temperatureMin)".capitalized(with: nil)
            
            case .sunset:
                
                 // Read the Sun Object from Response, convert to string
                cell.valueLabel?.text = weatherViewModel.searchResults?.sun?.sunset?.toDateString().description
                cell.keyLabel?.text =  "\(wDisplayRows.sunset)".capitalized(with: nil)
            
            case .sunrise:
                
                 // Read the Sun Object from Response, convert to DateString
                cell.valueLabel?.text = weatherViewModel.searchResults?.sun?.sunrise?.toDateString().description
                cell.keyLabel?.text =  "\(wDisplayRows.sunrise)".capitalized(with: nil)
            
            case .speed:
                
                // Read the Wind Object from Response, convert to string
                cell.valueLabel?.text = weatherViewModel.searchResults?.wind?.speed?.toString()
                cell.keyLabel?.text =  "Wind \(wDisplayRows.speed)".capitalized(with: nil)
                
            //Switch Case is Exhaustive - No Default is required.
            
            }
         
        }
     return cell
    }
}
