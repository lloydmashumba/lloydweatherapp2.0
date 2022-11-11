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
    
    
    //MARK: Current Weather
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
    
    //MARK: Forecast
    
    //days
    
    var day1 : XCUIElement {
        app.staticTexts["day1"]
    }
    var day2 : XCUIElement {
        app.staticTexts["day2"]
    }
    var day3 : XCUIElement {
        app.staticTexts["day3"]
    }
    var day4 : XCUIElement {
        app.staticTexts["day4"]
    }
    var day5 : XCUIElement {
        app.staticTexts["day5"]
    }
    
    //temps
    
    var tempDay1 : XCUIElement {
        app.staticTexts["tempDay1"]
    }
    var tempDay2 : XCUIElement {
        app.staticTexts["tempDay2"]
    }
    var tempDay3 : XCUIElement {
        app.staticTexts["tempDay3"]
    }
    var tempDay4 : XCUIElement {
        app.staticTexts["tempDay4"]
    }
    var tempDay5 : XCUIElement {
        app.staticTexts["tempDay5"]
    }
    
    //Buttons
    
    var saveBtn  : XCUIElement {
        app.buttons["saveBtn"]
    }
    var locationsBtn  : XCUIElement {
        app.buttons["favBtn"]
    }
    var infoBtn  : XCUIElement {
        app.buttons["info"]
    }
    
    var saveAlert : XCUIElement {
        app.alerts["Saved"]
    }
    
}
