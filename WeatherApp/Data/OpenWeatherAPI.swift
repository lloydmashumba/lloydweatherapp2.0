//
//  OpenWeatherAPI.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 10/11/2022.
//

import Foundation
import Combine

class OpenWeatherAPi : WeatherService{
    
    private let openApiStringUrl = "http://api.openweathermap.org/data/2.5/%@?lat=%@&lon=%@&units=metric&appid=1e8055ffb2635e34dd169d92bca3f972"
    private let currentWeatherPublisher = CurrentValueSubject<CurrentWeather?,DataError>(nil)
    private let weatherForecastPublisher = CurrentValueSubject<WeatherForecast?,DataError>(nil)
    
    func fetchCurrentWeather(lat : Double,lon : Double) -> AnyPublisher<CurrentWeather?, DataError> {
        guard let url : URL = URL(string: String(format: openApiStringUrl,"forecast",lat,lon)) else {
            currentWeatherPublisher.send(completion: .failure(.apiCallError("could not validate url")))
            return currentWeatherPublisher.eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data,urlResponse in
                guard let httpResponse = urlResponse as? HTTPURLResponse,
                                    httpResponse.statusCode == 200 else {
                    throw DataError.apiCallError("Failed to Connect to the internet")
                }
                return data
            }
            .decode(type: CurrentWeather?.self, decoder: JSONDecoder())
            .mapError({ error in
                return DataError.apiCallError(error.localizedDescription)
            })
            .eraseToAnyPublisher()
    }
    
    func fetchWeatherForecast(lat : Double,lon : Double) -> AnyPublisher<WeatherForecast?, DataError> {
        guard let url : URL = URL(string: String(format: openApiStringUrl,"forecast",lat,lon)) else {
            weatherForecastPublisher.send(completion: .failure(.apiCallError("could not validate url")))
            return weatherForecastPublisher.eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data,urlResponse in
                guard let httpResponse = urlResponse as? HTTPURLResponse,
                                    httpResponse.statusCode == 200 else {
                    throw DataError.apiCallError("Failed to Connect to the internet")
                }
                return data
            }
            .decode(type: WeatherForecast?.self, decoder: JSONDecoder())
            .mapError({ error in
                return DataError.apiCallError(error.localizedDescription)
            })
            .eraseToAnyPublisher()
    }
    
    
}
