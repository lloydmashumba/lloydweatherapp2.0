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
    private let iconContainer = UIView(frame: .zero)


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLabelStyle()
        setUpStackView()
        addSubview(forcastStack)
        
        forcastStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        forcastStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        forcastStack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20).isActive = true
        forcastStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
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
                iconContainer.backgroundColor = .yellow
        weatherIconView.image = UIImage(named: "sunny")
        weatherIconView.contentMode = .scaleAspectFit
        weatherIconView.frame = .init(x: 0, y: 0, width: 50, height: 50)
        forcastStack.addArrangedSubview(weatherIconView)//getImageContainer())
        forcastStack.addArrangedSubview(tempLabel)
    }
    //MARK: Icon
    //:set up Image view and return the container
//    private func getImageContainer() -> UIView{
//
//        //iconContainer.addSubview(weatherIconView)
//        //
//        //weatherIconView.topAnchor.constraint(equalTo: iconContainer.topAnchor).isActive = true
//        //weatherIconView.bottomAnchor.constraint(equalTo: iconContainer.bottomAnchor).isActive = true
//        //weatherIconView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor).isActive = true
////weatherIconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor).isActive = true
//        return iconContainer
//    }
}
