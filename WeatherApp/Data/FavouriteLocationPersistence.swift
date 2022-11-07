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
    
    //save location
    let output = PassthroughSubject<Output,Never>()
    
    func saveLocation(){
        do{
            try context.save()
        }catch{
            output.send(.error("Failed To Save Location. Please Try Again!"))
        }
    }
}
