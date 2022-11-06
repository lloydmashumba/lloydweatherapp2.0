//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 6/11/2022.
//

import Foundation
import Combine

protocol WeatherService {
    
    func fetchCurrentWeather() -> AnyPublisher<CurrentWeather?,DataError>
    func fetchWeatherForecast() -> AnyPublisher<WeatherForecast?,DataError>
}
