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
    private var viewHeight : CGFloat {
        UIScreen.main.bounds.height
    }
    private var input = PassthroughSubject<DashboardViewModel.Input,Never>()
    private var dashboardViewModel : DashboardViewModel?
    private var cancellables = Set<AnyCancellable>()
    //displayed current weather
    private var currentWeather : CurrentWeather?
    
    //:-Views
    //current weather
    var mainTempDescriptionStackView = UIStackView(frame:.zero)
    var temperatureLabel = UILabel()
    var weatherDescriptionLabel = UILabel()
    var saveBtn = UIButton()
    var maxRecordTemp = CurrentTempRecordView(frame: .zero)
    var currentRecordTemp = CurrentTempRecordView(frame: .zero)
    var minRecordTemp = CurrentTempRecordView(frame: .zero)
    var tempRecordViews : [CurrentTempRecordView] {
        [minRecordTemp,currentRecordTemp,maxRecordTemp]
    }
    
    //Forecast
    var forecastDay1 = ForecastView()
    var forecastDay2 = ForecastView()
    var forecastDay3 = ForecastView()
    var forecastDay4 = ForecastView()
    var forecastDay5 = ForecastView()
    
    private var forecastViews : [ForecastView]{
        [forecastDay1,forecastDay2,forecastDay3,forecastDay4,forecastDay5]
    }

    //:-Storyboard Views
    @IBOutlet weak var themeImageViewContainer: UIView!
    @IBOutlet weak var themeImageView: UIImageView!
    @IBOutlet weak var currentWeatherContainerView: UIView!
    @IBOutlet weak var tempRecordStackView: UIStackView!
    @IBOutlet weak var forcastStackView: UIStackView!
    @IBOutlet weak var themeImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tempRecordHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var forecastViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var emptyViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardViewModel = DashboardViewModel(service: WeatherMockData())
        bind()
        mainTempDescriptionStackView.axis = .vertical
        mainTempDescriptionStackView.distribution = .fill
        
        view.backgroundColor = UIColor(named: "forest_sunny")
        themeImageView.image = UIImage(named: "forest_sunny")
        
    }
    //MARK: Bind
    private func bind(){
        dashboardViewModel?.bind(input: input.eraseToAnyPublisher())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] output in
                switch output {
                case .locationSaved(let response):
                    print(response)
                case .currentWeather(let currentWeather):
                    self?.handleCurrentWeatherUpdates(currentWeather!)
                case .forecastWeather(let weatherForecast) :
                    self?.handleForecastUpdates(weatherForecast!)
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
        emptyViewHeightConstraint.constant = viewHeight * 0.07
        
        setUpCurrentTemperatureView()
        setUpRecordViews()
        setUpWeatherForecastView()
    }
    
    
    //MARK: - Current Weather
    //sets up the current weather views
    private func setUpCurrentTemperatureView(){
        
        //:- styling temperature label
        temperatureLabel.textColor = .white
        temperatureLabel.shadowColor = .black
        temperatureLabel.shadowOffset = .init(width: 0.2, height: 0.3)
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = .systemFont(ofSize: 48, weight: .heavy)
        temperatureLabel.accessibilityIdentifier = "temp"
        //:- styling weather description label
        weatherDescriptionLabel.textColor = .white
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.font = .systemFont(ofSize: 28, weight: .bold)
        weatherDescriptionLabel.accessibilityIdentifier = "condition"
        //setUpSaveButton
        setupSaveButton()
        //:- adding the views to mainTempDescriptionStackView
        mainTempDescriptionStackView.addArrangedSubview(temperatureLabel)
        mainTempDescriptionStackView.addArrangedSubview(weatherDescriptionLabel)
        mainTempDescriptionStackView.addArrangedSubview(saveBtn)
        //:-adding mainTempDescriptionStackView to currentWeatherContainerView
        currentWeatherContainerView.addSubview(mainTempDescriptionStackView)
        //:- constraining mainTempDescriptionStackView to currentWeatherContainerView
        mainTempDescriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        mainTempDescriptionStackView.centerXAnchor.constraint(equalTo: currentWeatherContainerView.centerXAnchor).isActive = true
        mainTempDescriptionStackView.topAnchor.constraint(equalTo: currentWeatherContainerView.topAnchor, constant: 72).isActive = true
        //mainTempDescriptionStackView.centerYAnchor.constraint(equalTo: currentWeatherContainerView.centerYAnchor).isActive = true
    }
    //MARK: Save Favourite
    private func setupSaveButton(){
        saveBtn.setTitle("Save As Favourite", for: .normal)
        saveBtn.setTitleColor(.white, for: .normal)
        saveBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        saveBtn.layer.borderColor = UIColor.white.cgColor
        saveBtn.layer.borderWidth = 1
        saveBtn.layer.cornerRadius = 8
        saveBtn.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)

    }
    //save location call
    @objc func saveTapped(){
        dashboardViewModel?.saveFavouriteLocation(weather: currentWeather!)
    }
    //MARK: - Temp Record
    //setting up the record view
    private func setUpRecordViews(){
        //title to temp record
        maxRecordTemp.tempLabel.text = "max"
        minRecordTemp.tempLabel.text = "min"
        currentRecordTemp.tempLabel.text = "current"
        //add accessibility identifier to temp
        currentRecordTemp.temp.accessibilityIdentifier = "tempCurrent"
        minRecordTemp.temp.accessibilityIdentifier = "tempMin"
        maxRecordTemp.temp.accessibilityIdentifier = "tempMax"
        //add the records to the temp record stack view
        
        for tempView in tempRecordViews{
            tempRecordStackView.addArrangedSubview(tempView)
        }
    }
    
    //MARK: Forecast
    //Sets up a five day forecast view
    private func setUpWeatherForecastView(){
        forecastDay1.tempLabel.accessibilityIdentifier = "tempDay1"
        forecastDay2.tempLabel.accessibilityIdentifier = "tempDay2"
        forecastDay3.tempLabel.accessibilityIdentifier = "tempDay3"
        forecastDay4.tempLabel.accessibilityIdentifier = "tempDay4"
        forecastDay5.tempLabel.accessibilityIdentifier = "tempDay5"
        
        forecastDay1.dayLabel.accessibilityIdentifier = "day1"
        forecastDay2.dayLabel.accessibilityIdentifier = "day2"
        forecastDay3.dayLabel.accessibilityIdentifier = "day3"
        forecastDay4.dayLabel.accessibilityIdentifier = "day4"
        forecastDay5.dayLabel.accessibilityIdentifier = "day5"
    }
    

}
//MARK: Updates
//methods that will handle view updates
extension DashboardViewController{
    
    //Handles current weather updates
    private func handleCurrentWeatherUpdates(_ currentWeather: CurrentWeather){
        self.currentWeather = currentWeather
        currentRecordTemp.temp.text = "\(currentWeather.main.temp)º"
        minRecordTemp.temp.text = "\(currentWeather.main.temp_min)º"
        maxRecordTemp.temp.text = "\(currentWeather.main.temp_max)º"
        temperatureLabel.text = "\(currentWeather.main.temp)º"
        weatherDescriptionLabel.text = currentWeather.weather[0].main == "Rain" ? "Rainny" : "Sunny"
    }
    
    private func handleForecastUpdates(_ forecast : [String : ForecastModel]){
        let sortedForecast = forecast.sorted(by:{$0.value.dt < $1.value.dt})
        for i in 0 ..< sortedForecast.count{
            let forecastView = forecastViews[i]
            print(sortedForecast[i].value)
            forecastView.heightAnchor.constraint(equalToConstant: viewHeight * 0.06).isActive = true
            forecastView.tempLabel.text = "\(sortedForecast[i].value.temp)º"
            forecastView.dayLabel.text = sortedForecast[i].key
            forecastView.weatherIconView.image = UIImage(named: sortedForecast[i].value.conditionIcon)

            forcastStackView.addArrangedSubview(forecastView)
        }
    }
    
}

