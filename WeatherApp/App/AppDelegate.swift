//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 3/11/2022.
//

import UIKit
import CoreData
import GooglePlaces
import CoreLocation
import Combine


@main
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate{
    //Progress
    private let progressView : Progress = {
        let vc = Progress()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        return vc
    }()
    
    //Location changed publisher
    let locationChangedPublisher = CurrentValueSubject<CLLocationCoordinate2D?,Never>(nil)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        GMSPlacesClient.provideAPIKey("AIzaSyAXFa4mJnbfK384so5E0WGiF8JWLKsOkus")
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    //MARK: location change
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationChangedPublisher.send(manager.location!.coordinate)
    }
    
    func locationServicesEnabled() async -> Bool {
        CLLocationManager.locationServicesEnabled()
    }

    // MARK: - Core Data
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WeatherApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //Mark Progress View
    func showProgress(_ vc : UIViewController){
        vc.present(progressView, animated: true)
    }
    func dismissProgress(){
        progressView.dismiss(animated: true)
    }
    
    
}

