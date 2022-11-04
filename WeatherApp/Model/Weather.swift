//
//  Weather.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 4/11/2022.
//

import Foundation

struct CurrentWeather : Decodable{
    var coord : Coordinate
    var weather : [Weather]
    var base : String
    var main : Main
    var visibility : Int
    var wind : Wind
    var rain : [String:Double]
    var clouds : Clouds
    var dt : Int
    var sys : Sys
    var timezone : Int
    var id : Int
    var name : String
    var cod : Int
}

struct Coordinate : Decodable{
    var lon : Double
    var lat : Double
}

struct Weather : Decodable{
    var id : Int
    var main : String
    var description : String
    var icon : String
}

struct Main : Decodable{
    var temp : Double
    var feels_like : Double
    var temp_min : Double
    var temp_max : Double
    var pressure : Int
    var humidity : Int
    var sea_level : Int
    var grnd_level : Int
}

struct Wind : Decodable{
    var speed : Double
    var deg : Int
    var gust : Double
}

struct Clouds : Decodable{
    var all : Int
}

struct Sys : Decodable{
    var id : Int
    var type : Int
    var country : String
    var sunrise : Int
    var sunset : Int
    
}
