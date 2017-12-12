//
//  ViewController.swift
//  Weather
//
//  Created by Aejaz Ahmed KI on 12/9/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherView:MainView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        weatherView?.setUpMyView()
        weatherView?.wetherDelegate = self
        
       if let lastSearchString = PersistentManager.sharedInstance.fetchDataFromStore(for: "SearchString")
       {
        getCurrentWeather(forCity: lastSearchString)
        
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : WeatherProtocol
{
    func getCurrentWeather(forCity city: String) {
     
        //Make the Service Call With the searched string and Return the Required Result
        weatherView?.weatherViewModel.setSearchString(searchString: city)
       
        weak var myViewController = self
        
        weatherView?.weatherViewModel.invokeWeatherService{ results,errorMesage in
            //Update the View Model with Results
            myViewController?.weatherView?.weatherViewModel.searchResults = results
            //Update my View with Latest Wether View
            myViewController?.weatherView?.updateMyView()
        }
        
    }
    
    func  getCurrentWeatherImage(withURL : URL?, toImage image: FTImageView)
    {
        guard let downloadURL = withURL else
        {
            print("Error :Download was unsuccessful, URL was nil")
            return;
        }
        
        image.downloadedFrom(url: downloadURL);
    }
    
    func showAlert(WithMessage errorMessage:String)
    {
        self.show(title: "Error", message: errorMessage, actionTitle: "Ok", preferredStyle: .alert, actionStyle: .default)
    }
}
