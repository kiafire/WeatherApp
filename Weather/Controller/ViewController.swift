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
       
        //Set up the initial view
        weatherView?.setUpMyView()
        
        //Set up the VC delegate to handle events - to fecth data
        weatherView?.wetherDelegate = self
        
        //If a last searchd String is available, use it to pre-populate the screen on launch
        if let lastSearchString = PersistentManager.sharedInstance.fetchDataFromStore(for: "SearchString")
        {
           
            //Get the current weather of the searched String
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
     
        // Display Loading Indicator before fetching nay data
        //Force Unwrap, we are sure View will be loaded by this point
        WLoadingIndicator.sharedInstance.showActivityIndicator(uiView: weatherView!)
        
        //Make the Service Call With the searched string and Return the Required Result
        weatherView?.weatherViewModel.setSearchString(searchString: city)
       
        weak var myViewController = self
        
        weatherView?.weatherViewModel.invokeWeatherService{ results,errorMesage in
            
            //Hide Loading Indicator
            WLoadingIndicator.sharedInstance.hideActivityIndicator(uiView: (myViewController?.weatherView)!)
            
            //Update the View Model with Results
            myViewController?.weatherView?.weatherViewModel.searchResults = results
            
            //Update my View with Latest Wether View
            myViewController?.weatherView?.updateMyView()
        }
        
    }
    
    //Retrieves the Image from Server
    func  getCurrentWeatherImage(withURL : URL?, toImage image: FTImageView)
    {
        //Validation to check URL is not empty
        guard let downloadURL = withURL else
        {
            print("Error :Download was unsuccessful, URL was nil")
            return;
        }
        //Use our ImageView Extension to download the image async
        image.downloadedFrom(url: downloadURL);
    }
    
    // Display an Error to the end user
    func showAlert(WithMessage errorMessage:String)
    {
        self.show(title: "Error", message: errorMessage, actionTitle: "Ok", preferredStyle: .alert, actionStyle: .default)
    }
}
