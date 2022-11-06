//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 6/11/2022.
//

import Foundation

struct ForecastModel {
    var dt : Double
    var main : String
    var temp : Double
    var conditionIcon : String {
        main == "Rain" ? "rainny" : main == "Clouds" ? "cloudy" :"sunny"
    }
    
}
