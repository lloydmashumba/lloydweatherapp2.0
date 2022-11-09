//
//  Progress.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 9/11/2022.
//

import UIKit

class Progress: UIViewController {
    
    var viewHeight = UIScreen.main.bounds.height
    var viewWidth = UIScreen.main.bounds.width

 

    override func viewDidLoad() {
        super.viewDidLoad()

        let progressIndicator : UIActivityIndicatorView =
            UIActivityIndicatorView(frame: .init(x: viewWidth * 0.5, y: viewHeight * 0.5, width: 60, height: 60))
        
        view.backgroundColor = .black.withAlphaComponent(0.3)
        
        view.addSubview(progressIndicator)
        progressIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        progressIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        progressIndicator.startAnimating()
        
    }
}
