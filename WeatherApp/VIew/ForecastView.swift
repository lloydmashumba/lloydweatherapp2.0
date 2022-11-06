//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 5/11/2022.
//

import UIKit

class ForecastView: UIView {
    
    //MARK: Properties
    private(set) var dayLabel = UILabel()
    private(set) var weatherIconView = UIImageView()
    private(set) var tempLabel = UILabel()
    
    private var forcastStack = UIStackView()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabelStyle()
        setUpStackView()
        addSubview(forcastStack)
        
        forcastStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        forcastStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        forcastStack.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Label Style
    //-set up style for labels
    private func setUpLabelStyle(){
        //day
        dayLabel.font = .systemFont(ofSize: 20, weight: .light)
        dayLabel.textColor = .white
        dayLabel.textAlignment = .left
        //temp
        tempLabel.font = .systemFont(ofSize: 20, weight: .bold)
        tempLabel.textColor = .white
        tempLabel.textAlignment = .center
    }
    
    
   //MARK: stack view
    //set up the layout of views
    private func setUpStackView(){
        
        forcastStack.axis = .horizontal
        forcastStack.distribution = .fillEqually
        forcastStack.alignment = .fill
        forcastStack.translatesAutoresizingMaskIntoConstraints = false
        forcastStack.addArrangedSubview(dayLabel)
    
        weatherIconView.image = UIImage(named: "sunny")
        weatherIconView.contentMode = .scaleAspectFit
        forcastStack.addArrangedSubview(weatherIconView)//getImageContainer())
        forcastStack.addArrangedSubview(tempLabel)
    }
}

extension ForecastView {
    convenience init(){
        self.init(frame: .zero)
    }
}
