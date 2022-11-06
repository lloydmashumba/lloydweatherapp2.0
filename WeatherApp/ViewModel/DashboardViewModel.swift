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
        case currentWeather(CurrentWeather?)
        case forecastWeather(WeatherForecast?)
    }
    let service : WeatherService
    
    init(service : WeatherService){
        self.service = service;
    }
    
    var cancellables = Set<AnyCancellable>()
    
    private let output = PassthroughSubject<Output,Never>()
    
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
        service.fetchWeatherForecast().sink { completion in
                if case .failure(let error) = completion{
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] result in
                self?.output.send(.forecastWeather(result))
            }
            .store(in: &cancellables)

    }
    
}
