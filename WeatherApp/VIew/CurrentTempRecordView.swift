//
//  CurrentTempRecordView.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 5/11/2022.
//

import UIKit

class CurrentTempRecordView: UIView {

    private let containerStackView = UIStackView(frame: .zero)
    
    private(set) var tempLabel = UILabel()
    private(set) var temp = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerStackView)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.distribution = .fill
        containerStackView.axis = .vertical
        containerStackView.alignment = .center
        setUpLabelStyle()
        
                
        containerStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        containerStackView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //:- create style from labels
    private func setUpLabelStyle(){
        
        tempLabel.textColor = .white
        tempLabel.font = .systemFont(ofSize: 16, weight: .light)
        
        temp.textColor = .white
        temp.font = .systemFont(ofSize: 20, weight: .bold)
        
        containerStackView.addArrangedSubview(temp)
        containerStackView.addArrangedSubview(tempLabel)
    }
    

}
