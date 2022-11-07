//
//  Constants.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 6/11/2022.
//

import Foundation
import UIKit

let appDelelagate = UIApplication.shared.delegate as! AppDelegate

enum DataError : Error{
    case mockDataError(String)
}
