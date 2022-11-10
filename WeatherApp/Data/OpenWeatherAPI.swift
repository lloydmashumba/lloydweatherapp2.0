//
//  OpenWeatherAPI.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 10/11/2022.
//

import Foundation
import Combine
import MapKit

class OpenWeatherAPi : WeatherService{
    
    private let openApiStringUrl = "https://api.openweathermap.org/data/2.5/%@?lat=%@&lon=%@&units=metric&appid=1e8055ffb2635e34dd169d92bca3f972"
    private let currentWeatherPublisher = CurrentValueSubject<CurrentWeather?,DataError>(nil)
    private let weatherForecastPublisher = CurrentValueSubject<WeatherForecast?,DataError>(nil)
    
    private var coordinate : (Double,Double)? {
        if let location : CLLocationCoordinate2D = CLLocationManager().location?.coordinate {
            return (location.latitude,location.longitude)
        }
        return nil
    }
    
    func fetchCurrentWeather() -> AnyPublisher<CurrentWeather?, DataError> {
        
        guard let coord : (Double,Double) = coordinate else{
            currentWeatherPublisher.send(completion: .failure(.locationFailure("Could not figure out location,make sure the app can access location from settings!")))
            return currentWeatherPublisher.eraseToAnyPublisher()
        }
        
        
        guard let url : URL = URL(string: String(format: openApiStringUrl,"weather",String(coord.0),String(coord.1))) else {
            currentWeatherPublisher.send(completion: .failure(.apiCallError("could not validate Current Weather url")))
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
    
    func fetchWeatherForecast() -> AnyPublisher<WeatherForecast?, DataError> {
        
        guard let coord : (Double,Double) = coordinate else{
            weatherForecastPublisher.send(completion: .failure(.locationFailure("Could not figure out location,make sure the app can access location from settings!")))
            return weatherForecastPublisher.eraseToAnyPublisher()
        }
        
        guard let url : URL = URL(string: String(format: openApiStringUrl,"forecast",String(coord.0),String(coord.1))) else {
            weatherForecastPublisher.send(completion: .failure(.apiCallError("could not validate forecast url")))
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
