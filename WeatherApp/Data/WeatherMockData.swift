//
//  WeatherMockData.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 6/11/2022.
//

import Foundation
import Combine

//Extending the bundle to load data from the files
extension Bundle{
    
    func loadDataFrom<T : Decodable>(file name: String) throws  -> T {
        
        guard let url = url(forResource: name, withExtension: nil) else {
            throw DataError.mockDataError("file '\(name)' could not be found.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            throw DataError.mockDataError("failed to load '\(name)' from bundle.")
        }
        
        let loaded : T?
        do{
            loaded = try JSONDecoder().decode(T.self, from: data)
                //"Failed to decode '\(name)' from bundle.")

        }catch{
            print(error)
            throw DataError.mockDataError(error.localizedDescription)
        }
        
        return loaded!
    }
}


class WeatherMockData : WeatherService{
    
    private var currentWeatherPublisher = CurrentValueSubject<CurrentWeather?,DataError>(nil)
    private var forecastWeatherPublisher = CurrentValueSubject<WeatherForecast?,DataError>(nil)
    
    func fetchCurrentWeather() -> AnyPublisher<CurrentWeather?, DataError> {
        do{
            let data : CurrentWeather = try Bundle.main.loadDataFrom(file: "current_weather.json")
            currentWeatherPublisher.send(data)
            
        }
        catch{
            
            let er = error as! DataError
            if case .mockDataError(let desc) = er {
                print(desc)
            }
            currentWeatherPublisher.send(completion: .failure(error as! DataError) )
        }
        return currentWeatherPublisher.eraseToAnyPublisher()
    }
    
    func fetchWeatherForecast() -> AnyPublisher<WeatherForecast?, DataError> {
        do{
            let data : WeatherForecast = try Bundle.main.loadDataFrom(file: "forecast_weather.json")
            forecastWeatherPublisher.send(data)
            
        }
        catch{
            
            let er = error as! DataError
            if case .mockDataError(let desc) = er {
                print(desc)
            }
            forecastWeatherPublisher.send(completion: .failure(error as! DataError) )
        }
        return forecastWeatherPublisher.eraseToAnyPublisher()
    }
}
