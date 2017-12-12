//
//  PersistentManager.swift
//  Weather
//
//  Created by Aejaz Ahmed KI on 12/9/17.
//  Copyright © 2017 kiafire. All rights reserved.
//

import Foundation

// This class is used to stopre the last searched string on NSUSerDefaults and to prepopulate the same during next app launch.

final class PersistentManager {
    
    ///MARK: - Initializer : Singleton
    static let sharedInstance = PersistentManager()
    
    private init() {
        ///Singleton Initializer must be private
    }
    
    /// is an instance of Userdefaults used in DataStoreManager
    private let defaultStore: UserDefaults = UserDefaults.standard
    
    ///MARK: Fetch Data
    
    public func fetchDataFromStore(for key: String) -> String? {
        let valueForKey = defaultStore.object(forKey: key) as! String?
        return valueForKey
    }
    
    ///MARK: - Save Data
    
    ///If there is any custom type we need to store, we need to implement CodingProtocol and Coding Key to Encode and Decode the data before saving the same in User Defaults
    public func saveDataToStore(for dictionary: Dictionary<String, Any>) {
        //Save the user data
        guard dictionary.count > 0 else {
            print("Cannot save user data as dictionary values are 0") //Will be replaced by logger
            return
        }
        ///Save the dictionary to the user defaults.
        dictionary.forEach({
            defaultStore.set($0.value, forKey: $0.key)
        })
    }
    
    ///MARK: - Validate Data
    
    //Check if the given value is present in the dictonary or not
    public func hasValue(for key: String) -> Bool {
        if let _ = defaultStore.value(forKey: key) {
            return true
        }
        return false
    }
    
    /// Removes the data from the store
    ///
    /// - Parameter key: key that needs to be removed
    public func removeDataFromStore(for key: String) {
        defaultStore.removeObject(forKey: key)
    }
    
    ///Denitializer called
    deinit {
        print("Deinitialzied DataStore Manager") //Will be replaced by logger API
    }
}


