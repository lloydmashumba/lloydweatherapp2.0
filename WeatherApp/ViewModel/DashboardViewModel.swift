//
//  DashboardViewModel.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 6/11/2022.
//

import Foundation
import Combine

class DashboardViewModel {
    
    //input received from the DashboardViewController
    enum Input{
        case viewDidAppear
    }
    //output sent to the DashboardViewController
    enum Output{
        case locationSaved(String)
        case currentWeather(CurrentWeather?)
        case forecastWeather([String:ForecastModel]?)
    }
    let service : WeatherService
    
    init(service : WeatherService){
        self.service = service;
        subscribeToFavouriteLocationPersistenceOutput()
    }
    
    var cancellables = Set<AnyCancellable>()
    private let output = PassthroughSubject<Output,Never>()
    
    var locationPersistence = FavouriteLocationPersistence.shared
    let context = appDelelagate.persistentContainer.viewContext
    
    //MARK: Bind
    //Bind ViewModel,View Controller on their "Input Output" publishers
    func bind(input : AnyPublisher<Input,Never>) -> AnyPublisher<Output,Never>{
        input.sink {[weak self] value in
            switch value {
            case .viewDidAppear :
                self?.handleGetCurrentWeather()
                self?.handleGetWeatherForecast()
            }
        }
        .store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    //MARK: Current Weather Call
    //handles response for current weather call
    private func handleGetCurrentWeather(){
        service.fetchCurrentWeather().sink { completion in
                if case .failure(let error) = completion{
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] result in
                self?.output.send(.currentWeather(result))
            }
            .store(in: &cancellables)

    }
    //MARK: Weather Forecast Call
    //handles response for current weather call
    private func handleGetWeatherForecast(){
        service.fetchWeatherForecast()
            .map({Dictionary(grouping: $0!.list){
                self.forecastDay(Date(timeIntervalSince1970: .init(floatLiteral: $0.dt)))
            }})
            .map({self.orderdForecast($0)})
            .sink { completion in
                if case .failure(let error) = completion{
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] result in
                self?.output.send(.forecastWeather(result))
            }
            .store(in: &cancellables)

    }
    
    func saveFavouriteLocation(weather : CurrentWeather){
        let favourite = Favourite(context: context)
        favourite.city = weather.name
        favourite.sunrise = weather.sys.sunrise ?? 0.0
        favourite.sunset = weather.sys.sunset ?? 0.0
        favourite.country_code = weather.sys.country
        
        let coord = Coord(context: context)
        coord.lat = weather.coord?.lat ?? 0.0
        coord.lat = weather.coord?.lat ?? 0.0
        favourite.coord = coord
        
        locationPersistence.saveLocation()
    }
    
}

//MARK: Setup
extension DashboardViewModel {
    //Format forecat day
    func forecastDay(_ date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from:date)
    }
    
    func orderdForecast(_ forecast : [String:[CurrentWeather]]) -> [String : ForecastModel] {
        var convertedForecast = [String : ForecastModel]()
        for condition in forecast {
            let dayForecast = condition.value.max { $0.dt < $1.dt}
            convertedForecast[condition.key] = .init(dt:dayForecast!.dt,main: dayForecast!.weather[0].main, temp: dayForecast!.main.temp)
        }
        convertedForecast.removeValue(forKey: forecastDay(Date()))
        return convertedForecast
    }
    
    func subscribeToFavouriteLocationPersistenceOutput(){
        locationPersistence.output
            .sink { value in
                if case .success = value {
                    self.output.send(.locationSaved("location save successfully!"))
                }
            }
            .store(in: &cancellables)
    }
}
