//
//  FavouriteLocationViewController.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 8/11/2022.
//

import UIKit
import Combine

class FavouriteLocationViewController: UIViewController{
    
    
    @IBOutlet weak var favouriteLocationContainerView: UIView!
    @IBOutlet weak var favouriteLocationTableView: UITableView!
    
    @IBOutlet weak var locationsTableView: UITableView!
    //view model
    let favouriteLocationsViewModel = FavouriteLocationsViewModel()
    
    //input publisher to view model
    let input = PassthroughSubject<FavouriteLocationsViewModel.Input,Never>()
    
    //cancellables
    private var cancellables = Set<AnyCancellable>()
    //theme
    var theme : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteLocationTableView.rowHeight = 60
        favouriteLocationTableView.separatorColor = .clear
        favouriteLocationContainerView.backgroundColor = UIColor(named:theme != nil ? theme! : "forest_sunny")
        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "Favourites"
    }
    override func viewDidAppear(_ animated: Bool) {
        input.send(.viewDidAppear)
        
    }
    

    
    //MARK: Bind
    private func bind(){
        //Subscribe to the view model
        favouriteLocationsViewModel.bind(input.eraseToAnyPublisher())
            .receive(on: DispatchQueue.main)
            .sink {[weak self] value in
                switch value {
                case .noLocationsAlert:
                    let alert = UIAlertController(title: "No Favourites", message: "Could not find your favourite locations!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "close", style: .destructive) { action in
                        self?.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(action)
                    self?.present(alert, animated: true)
                case .loadLocations :
                    self?.locationsTableView.reloadData()
                }
            }
            .store(in: &cancellables)
        
    }
    
}

//MARK: DataSource
extension FavouriteLocationViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteLocationsViewModel.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = favouriteLocationsViewModel.locations[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteLocationTableViewCell") as? FavouriteLocationTableViewCell else {
            return UITableViewCell()
        }
        cell.city_name.text = "\(location.city!),\(location.country_code!)"
        cell.coord.text = "[\(location.coord!.lat),\(location.coord!.lon)]"
        cell.time.text = "sun \(sunTime(from: location.sunset)) - \(sunTime(from: location.sunrise))"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            input.send(.delete(favouriteLocationsViewModel.locations[indexPath.row]))
        }
    }
    
    private func sunTime(from dt: Double) -> String{
        return Date(timeIntervalSince1970: .init(floatLiteral: dt))
            .formatted(date: .omitted, time: .shortened)
    }
    
}

//MARK: Delegate
extension FavouriteLocationViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MapViewController()
        let location = favouriteLocationsViewModel.locations[indexPath.row]
        vc.pinTitle = "\(location.city!),\(location.country_code!)"
        vc.lon = location.coord?.lon
        vc.lat = location.coord?.lat
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
