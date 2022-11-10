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
        case deleted
        case deletionFailed(String)
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
        
        let fetchRequest = Favourite.fetchRequest()
        guard let savedLocations : [Favourite] = try? context.fetch(fetchRequest) else{
            return Just([Favourite]()).eraseToAnyPublisher()
        }
        return Just(savedLocations).eraseToAnyPublisher()
    }
    
    //
    func retrievLocationByName(_ name : String) -> AnyPublisher<Favourite?,Never>{
        let fetchRequest = Favourite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "city = %@",name)
        guard let locations : [Favourite] = try? context.fetch(fetchRequest) else{
            return Just(nil).eraseToAnyPublisher()
        }
        if !locations.isEmpty {
            return Just(locations[0]).eraseToAnyPublisher()
        }
        return Just(nil).eraseToAnyPublisher()
    }
    
    func deleteLocation(location: Favourite){
            do{
                context.delete(location)
                try context.save()
                output.send(.deleted)
            }catch{
                output.send(.deletionFailed("Failed to delete location,Please try Again!"))
            }
        }
    
    
}
