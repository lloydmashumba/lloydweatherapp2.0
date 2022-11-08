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
        case viewDidAppear
        case reloadListOfFavouriteLocations
    }
    
    //expected input to FavouriteLocationsViewController
    enum Output{
        case listOfFavouriteLocations([Favourite])
    }
    
    //output publisher to FavouriteLocationsViewController
    let output = PassthroughSubject<Output,Error>()
    
    //cancellable list
    private var cancellables = Set<AnyCancellable>()
    
    private let locationPersistence = FavouriteLocationPersistence.shared
    
    //MARK: Bind
    func bind(_ input : AnyPublisher<Input,Never>){
        
        input.sink {[weak self] value in
            switch value {
            case .reloadListOfFavouriteLocations,.viewDidAppear:
                self?.loadSavedLocations()
            }
        }
        .store(in: &cancellables)
        
    }
    
    private func loadSavedLocations(){
        locationPersistence.fetchAllSavedLocations()
            .sink {[weak self] locations in
                self?.output.send(.listOfFavouriteLocations(locations))
            }
            .store(in: &cancellables)
    }
    
    
    
    
}
