//
//  ViewController.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 3/11/2022.
//

import UIKit
import Combine

class DashboardViewController: UIViewController {
    
    
    //MARK: Properties
    private var input = PassthroughSubject<DashboardViewModel.Input,Never>()
    private var dashboardViewModel : DashboardViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    var mainTempDescriptionStackView = UIStackView(frame:.zero)

    var temperatureLabel = UILabel()
    var weatherDescriptionLabel = UILabel()
    
    var maxRecordTemp = CurrentTempRecordView(frame: .zero)
    var currentRecordTemp = CurrentTempRecordView(frame: .zero)
    var minRecordTemp = CurrentTempRecordView(frame: .zero)

    //MARK: dashboard views
    @IBOutlet weak var themeImageViewContainer: UIView!
    @IBOutlet weak var themeImageView: UIImageView!
    @IBOutlet weak var currentWeatherContainerView: UIView!
    @IBOutlet weak var tempRecordStackView: UIStackView!
    
    @IBOutlet weak var forcastStackView: UIStackView!
    
    //MARK: constraints
    @IBOutlet weak var themeImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tempRecordHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var forecastViewHeightConstraint: NSLayoutConstraint!
    private var viewHeight : CGFloat {
        UIScreen.main.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardViewModel = DashboardViewModel(service: WeatherMockData())
        bind()
        mainTempDescriptionStackView.axis = .vertical
        mainTempDescriptionStackView.distribution = .fill
        
        view.backgroundColor = UIColor(named: "forest_sunny")
        themeImageView.image = UIImage(named: "forest_sunny")
        
//        let days = ["Sunday","Monday","Tuesday","Wednesday","Thursday"]
//
//        for i in 0..<days.count {
//            let forcast = ForecastView(frame: .init(x: 0, y: 0, width: 0, height: viewHeight * 0.6))
//            forcast.tempLabel.text = "\(Int.random(in: 30 ... 35))"
//            forcast.dayLabel.text = days[i]
//
//            forcastStackView.addArrangedSubview(forcast)
//        }
        
    }
    private func bind(){
        dashboardViewModel?.bind(input: input.eraseToAnyPublisher())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] output in
                switch output {
                case .currentWeather(let currentWeather):
                    self?.handleCurrentWeatherUpdates(currentWeather!)
                }
            })
            .store(in: &cancellables)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        input.send(.viewDidAppear)
    }

    //:- design dynamic set up
    override func viewWillAppear(_ animated: Bool) {
        themeImageViewHeightConstraint.constant = viewHeight * 0.4
        tempRecordHeightConstraint.constant = viewHeight * 0.06
        forecastViewHeightConstraint.constant = viewHeight * 0.3
        
        setUpCurrentTemperatureView()
        setUpRecordViews()
    }
    
    //MARK: - setting up the temperature view
    func setUpCurrentTemperatureView(){
        
        //:- styling temperature lable
        temperatureLabel.textColor = .white
        temperatureLabel.shadowColor = .black
        temperatureLabel.shadowOffset = .init(width: 0.2, height: 0.3)
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = .systemFont(ofSize: 60, weight: .heavy)
        temperatureLabel.accessibilityIdentifier = "temp"
        
        //:- styling weather description label
        weatherDescriptionLabel.textColor = .white
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.font = .systemFont(ofSize: 40, weight: .bold)
        weatherDescriptionLabel.accessibilityIdentifier = "condition"
        
        mainTempDescriptionStackView.addArrangedSubview(temperatureLabel)
        mainTempDescriptionStackView.addArrangedSubview(weatherDescriptionLabel)
        
        currentWeatherContainerView.addSubview(mainTempDescriptionStackView)
        
        mainTempDescriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        
        mainTempDescriptionStackView.centerXAnchor.constraint(equalTo: currentWeatherContainerView.centerXAnchor).isActive = true
        mainTempDescriptionStackView.centerYAnchor.constraint(equalTo: currentWeatherContainerView.centerYAnchor).isActive = true
    }
    
    //MARK: - setting up the record view
    func setUpRecordViews(){
        
        maxRecordTemp.tempLabel.text = "min"
        minRecordTemp.tempLabel.text = "current"
        currentRecordTemp.tempLabel.text = "min"

        currentRecordTemp.temp.accessibilityIdentifier = "tempCurrent"
        minRecordTemp.temp.accessibilityIdentifier = "tempMin"
        maxRecordTemp.temp.accessibilityIdentifier = "tempMax"
        tempRecordStackView.addArrangedSubview(minRecordTemp)
        tempRecordStackView.addArrangedSubview(currentRecordTemp)
        tempRecordStackView.addArrangedSubview(maxRecordTemp)
        
    }
    

}
//MARK: Updates
//methods that will handle view updates
extension DashboardViewController{
    
    //Handles current weather updates
    private func handleCurrentWeatherUpdates(_ currentWeather: CurrentWeather){
        currentRecordTemp.temp.text = "\(currentWeather.main.temp)º"
        minRecordTemp.temp.text = "\(currentWeather.main.temp_min)º"
        maxRecordTemp.temp.text = "\(currentWeather.main.temp_max)º"
        temperatureLabel.text = "\(currentWeather.main.temp)º"
        weatherDescriptionLabel.text = currentWeather.weather[0].main == "Rain" ? "Rainny" : "Sunny"
    }
    
}

