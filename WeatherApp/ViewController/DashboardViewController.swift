//
//  ViewController.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 3/11/2022.
//

import UIKit

class DashboardViewController: UIViewController {
    
    
    //MARK: Properties
    
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
    
    
    //MARK: constraints
    @IBOutlet weak var themeImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tempRecordHeightConstraint: NSLayoutConstraint!
    
    
    private var viewHeight : CGFloat {
        UIScreen.main.bounds.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTempDescriptionStackView.axis = .vertical
        mainTempDescriptionStackView.distribution = .fill
        
        temperatureLabel.text = "80"
        weatherDescriptionLabel.text = "Sunny"
        
        view.backgroundColor = UIColor(named: "forest_sunny")
        themeImageView.image = UIImage(named: "forest_sunny")
        
    }

    //:- design dynamic set up
    override func viewWillAppear(_ animated: Bool) {
        themeImageViewHeightConstraint.constant = viewHeight * 0.4
        tempRecordHeightConstraint.constant = viewHeight * 0.06
        
        
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
        
        //:- styling weather description label
        weatherDescriptionLabel.textColor = .white
        weatherDescriptionLabel.textAlignment = .center
        weatherDescriptionLabel.font = .systemFont(ofSize: 40, weight: .bold)
        
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
        maxRecordTemp.temp.text = "\(32)"
        
        minRecordTemp.tempLabel.text = "current"
        minRecordTemp.temp.text = "\(35)"
        
        currentRecordTemp.tempLabel.text = "min"
        currentRecordTemp.temp.text = "\(38)"
        
        tempRecordStackView.addArrangedSubview(minRecordTemp)
        tempRecordStackView.addArrangedSubview(currentRecordTemp)
        tempRecordStackView.addArrangedSubview(maxRecordTemp)
        
    }
    

}

