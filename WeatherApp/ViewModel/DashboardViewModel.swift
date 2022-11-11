//
//  DashboardViewModel.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 6/11/2022.
//

import Foundation
import Combine
import MapKit
import GooglePlaces

class DashboardViewModel {
    
    //input received from the DashboardViewController
    enum Input{
        case viewDidAppear
        case save(CurrentWeather)
    }
    //output sent to the DashboardViewController
    enum Output{
        case errorAlert(String)
        case details(Details?)
        case locationSaveSuccess(String)
        case currentWeather(CurrentWeather?)
        case forecastWeather([String:ForecastModel]?)
        case locationSaved(Bool)
    }
    let service : WeatherService
    
    init(service : WeatherService){
        self.service = service;
        subscribeToFavouriteLocationPersistenceOutput()
        if !(self.service is WeatherMockData){
            bindLocationUpdate()
        }
        
    }
    
    var cancellables = Set<AnyCancellable>()
    private let output = PassthroughSubject<Output,Never>()
    
    var locationPersistence = FavouriteLocationPersistence.shared
    let context = appDelelagate.persistentContainer.viewContext
    
    //places client
    private let placesClient = GMSPlacesClient.shared()
    
    //MARK: Bind
    //Bind ViewModel,View Controller on their "Input Output" publishers
    func bind(input : AnyPublisher<Input,Never>) -> AnyPublisher<Output,Never>{
        input.sink {[weak self] value in
            switch value {
            case .save(let currentWeather):
                self?.saveFavouriteLocation(weather: currentWeather)
            case .viewDidAppear :
                self?.handleGetCurrentWeather()
            }
        }
        .store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    
    //MARK: Current Weather Call
    //handles response for current weather call
    private func handleGetCurrentWeather(){
        service.fetchCurrentWeather().sink {[weak self] completion in
                if case .failure(let error) = completion{
                    switch error {
                    case .locationFailure(let message),
                            .apiCallError(let message),
                            .mockDataError(let message) :
                        self?.output.send(.errorAlert(message))
                    }
                }
            } receiveValue: { [weak self] result in
                self?.output.send(.currentWeather(result))
                if result != nil{
                    self?.checkIfLocationSaved(weather: result!)
                }
                self?.handleGetWeatherForecast()
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
            .sink {[weak self] completion in
                if case .failure(let error) = completion{
                    switch error {
                    case .locationFailure(let message),
                            .apiCallError(let message),
                            .mockDataError(let message) :
                        self?.output.send(.errorAlert(message))
                    }
                    
                }
            } receiveValue: { [weak self] result in
                self?.output.send(.forecastWeather(result))
            }
            .store(in: &cancellables)

    }
    //MARK: Save
    func saveFavouriteLocation(weather : CurrentWeather){
        let favourite = Favourite(context: context)
        favourite.city = weather.name
        favourite.sunrise = weather.sys?.sunrise ?? 0.0
        favourite.sunset = weather.sys?.sunset ?? 0.0
        favourite.country_code = weather.sys?.country
        
        let coord = Coord(context: context)
        coord.lat = weather.coord?.lat ?? 0.0
        coord.lon = weather.coord?.lon ?? 0.0
        favourite.coord = coord
        
        locationPersistence.saveLocation()
    }
    
    //checkSaved Location
    private func checkIfLocationSaved(weather : CurrentWeather){
        locationPersistence.retrievLocationByName(weather.name ?? "")
            .sink {[weak self] location in
                self?.output.send(.locationSaved(location != nil))
            }
            .store(in: &cancellables)

    }
    
    //MARK: Subscribe to Current Location
    private func bindLocationUpdate(){
        appDelelagate.locationChangedPublisher
            .sink {[weak self] coord in
                guard coord != nil else {
                    return
                }
                self?.handleGetCurrentWeather()
                self?.getLocationLikelyhood()
            }
            .store(in: &cancellables)
    }

    //About the current location
    private func getLocationLikelyhood() {
        let placeFields: GMSPlaceField = [.name,.formattedAddress]
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeDetails, error) in

             guard error == nil else {
               print("Current place error: \(error?.localizedDescription ?? "")")
                 self?.output.send(.details(nil))
               return
             }

             guard let place = placeDetails?.first?.place else {
                 self?.output.send(.details(nil))
               return
             }
            
            self?.output.send(.details(Details(name: place.name ?? "", address: place.formattedAddress ?? "")))
            
           }
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
    //oreder received forecast
    func orderdForecast(_ forecast : [String:[CurrentWeather]]) -> [String : ForecastModel] {
        var convertedForecast = [String : ForecastModel]()
        for condition in forecast {
            let dayForecast = condition.value.max { $0.dt < $1.dt}
            convertedForecast[condition.key] = .init(dt:dayForecast!.dt,main: dayForecast!.weather[0].main, temp: dayForecast!.main.temp)
        }
        convertedForecast.removeValue(forKey: forecastDay(
            service is WeatherMockData ? Date(timeIntervalSince1970: .init(floatLiteral: 1667768400)): Date()))
        return convertedForecast
    }
    
    func subscribeToFavouriteLocationPersistenceOutput(){
        locationPersistence.output
            .sink { value in
                if case .success = value {
                    self.output.send(.locationSaveSuccess("location save successfully!"))
                }
            }
            .store(in: &cancellables)
    }
}
