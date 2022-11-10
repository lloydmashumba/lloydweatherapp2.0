//
//  Weather.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 4/11/2022.
//

import Foundation

struct CurrentWeather : Decodable{
    var coord : Coordinate?
    var weather : [Weather]
    var base : String?
    var main : Main
    var visibility : Int?
    var wind : Wind?
    var rain : [String : Double]?
    var clouds : Clouds?
    var dt : Double
    var sys : Sys?
    var timezone : Int?
    var id : Int?
    var name : String?
    var cod : Int?
    var dt_txt : String?
}

struct WeatherForecast : Decodable {
    var cod : String
    var message : Int
    var cnt : Int
    var list : [CurrentWeather]
}

struct Coordinate : Decodable{
    var lon : Double
    var lat : Double
}

struct Weather : Decodable{
    var id : Int?
    var main : String
    var description : String?
    var icon : String?
    var conditionForTheme : String {
        main == "Rain" ? "Rainny" : main == "Clouds" ? "Cloudy" :"Sunny"
    }
}

struct Main : Decodable{
    var temp : Double
    var feels_like : Double?
    var temp_min : Double
    var temp_max : Double
    var pressure : Int?
    var humidity : Int?
    var sea_level : Int?
    var grnd_level : Int?
    
}

struct Wind : Decodable{
    var speed : Double?
    var deg : Int?
    var gust : Double?
}

struct Clouds : Decodable{
    var all : Int?
}

struct Sys : Decodable{
    var pod : String?
    var country : String?
    var sunrise : Double?
    var sunset : Double?
    
}
