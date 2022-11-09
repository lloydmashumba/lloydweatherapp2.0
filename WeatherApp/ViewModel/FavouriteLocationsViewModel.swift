//
//  FavouriteLocationsViewModel.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 8/11/2022.
//

import Foundation
import Combine

class FavouriteLocationsViewModel {
    
    //expected input from FavouriteLocationsViewController
    enum Input{
        case delete(Favourite)
        case viewDidAppear
        case reloadListOfFavouriteLocations
    }
    
    //expected input to FavouriteLocationsViewController
    enum Output{
        case loadLocations
    }
    
    init(){
        subscribeToLocationPersistence()
    }
    
    //output publisher to FavouriteLocationsViewController
    private let output = PassthroughSubject<Output,Never>()
    
    //cancellable list
    private var cancellables = Set<AnyCancellable>()
    
    private let locationPersistence = FavouriteLocationPersistence.shared
    
    private(set) var locations = [Favourite]()
    
    //MARK: Bind
    func bind(_ input : AnyPublisher<Input,Never>) -> AnyPublisher<Output,Never> {
        
        input.sink {[weak self] value in
            switch value {
            case .reloadListOfFavouriteLocations,.viewDidAppear:
                self?.loadSavedLocations()
            case .delete(let favourite) :
                self?.locationPersistence.deleteLocation(location: favourite)
            }
        }
        .store(in: &cancellables)
        return output.eraseToAnyPublisher()
    }
    //MARK: getLocations
    private func loadSavedLocations(){
        locationPersistence.fetchAllSavedLocations()
            .sink {[weak self] locations in
                self?.locations = locations
                self?.output.send(.loadLocations)
            }
            .store(in: &cancellables)
    }
    
}

extension FavouriteLocationsViewModel {
    //Subscribe to favourite location persistence
    func subscribeToLocationPersistence(){
        locationPersistence.output
            .sink {[weak self] value in
                if case .deleted = value {
                    print("delete")
                    self?.loadSavedLocations()
                }
            }
            .store(in: &cancellables)
    }
}
