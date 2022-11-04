//
//  ViewController.swift
//  WeatherApp
//
//  Created by Lloyd Mashumba on 3/11/2022.
//

import UIKit

class DashboardViewController: UIViewController {

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
        
        view.backgroundColor = UIColor(named: "forest_sunny")
        themeImageView.image = UIImage(named: "forest_sunny")
        
    }

    //:- Setup constraints depending on the height view
    override func viewWillAppear(_ animated: Bool) {
        themeImageViewHeightConstraint.constant = viewHeight * 0.4
        tempRecordHeightConstraint.constant = viewHeight * 1
    }

}

