//
//  DashboardElements.swift
//  WeatherAppUITests
//
//  Created by Lloyd Mashumba on 5/11/2022.
//

import Foundation
import XCTest


public struct DashboardElements {
    
    let app : XCUIApplication
    
    var temperature : XCUIElement{
        app.staticTexts["temp"]
    }
    
    var weatherCondition : XCUIElement {
        app.staticTexts["condition"]
    }
    
    var tempCurrent : XCUIElement {
        app.staticTexts["tempCurrent"]
    }
    
    var tempMin : XCUIElement {
        app.staticTexts["tempMin"]
    }
    var tempMax : XCUIElement {
        app.staticTexts["tempMax"]
    }
}
