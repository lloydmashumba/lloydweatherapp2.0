//
//  FavouriteLocationPersistence.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 7/11/2022.
//

import Foundation
import Combine

class FavouriteLocationPersistence {
    
    static let shared = FavouriteLocationPersistence()
    
    private var context = appDelelagate.persistentContainer.viewContext
    
    //output when changes are made on the db
    enum Output {
        case listOfLocations([Favourite])
        case location(Favourite)
        case success
        case error(String)
    }
    
    //save
    let output = PassthroughSubject<Output,Never>()
    
    //save location
    func saveLocation(){
        do{
            try context.save()
            output.send(.success)
        }catch{
            output.send(.error("Failed To Save Location. Please Try Again!"))
        }
    }
    
    //Fetch Location
    
    func fetchAllSavedLocations() -> AnyPublisher<[Favourite],Never>{
        
        var fetchRequest = Favourite.fetchRequest()
        guard let savedLocations : [Favourite] = try? context.fetch(fetchRequest) else{
            return Just([Favourite]()).eraseToAnyPublisher()
        }
        return Just(savedLocations).eraseToAnyPublisher()
    }
    
    
}
