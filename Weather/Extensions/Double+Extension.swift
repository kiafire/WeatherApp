//
//  Double+Extensions.swift
//  Weather


import Foundation

// MARK: - Extension Double
extension Double {
  
  /// Double value to string
  ///
  /// - Returns: return the double value to string
  func toString() -> String {
    return String(format: "%.2f",self)
  }
}
