//
//  Double+Extensions.swift
//  Weather


import Foundation
import UIKit
// MARK: - Extension Double
extension Double {
  
  /// Double value to string
  ///
  /// - Returns: return the double value to string
  func toString() -> String {
    return String(format: "%.2f",self)
  }

    //converts the double value to Int format , if the value is larger returns nil
    func toInt() -> Int? {
        if self > Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return nil
        }
    }
    
    //Converts the Double Value in MilliSeconds to DateString.
    //example - 1513081378.0
    func toDateString() -> String
    {
        print(self);
        print(self/1000)
        let daFormat  = DateFormatter.init()
        daFormat.dateFormat = "hh:mm:ss a"
        
        // TODO : Note sure which format the service is returning, could not help much in this
        return daFormat.string(from: Date.init(timeIntervalSinceReferenceDate: self/1000))
    }
}
