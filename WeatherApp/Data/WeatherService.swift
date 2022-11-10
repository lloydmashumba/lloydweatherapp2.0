//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 6/11/2022.
//

import Foundation
import Combine

protocol WeatherService {
    
    func fetchCurrentWeather(lat : Double,lon : Double) -> AnyPublisher<CurrentWeather?,DataError>
    func fetchWeatherForecast(lat : Double,lon : Double) -> AnyPublisher<WeatherForecast?,DataError>
}
