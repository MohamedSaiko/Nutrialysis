//
//  DoubleExtension.swift
//  Nutrialysis
//
//  Created by Mohamed Sayed on 27.04.24.
//

import Foundation

extension Double {
    func roundedTo(numberOfDecimals: Int, withString string: String) -> String {
        return String(format: "\(string): %.\(numberOfDecimals)f", self)
    }
}
