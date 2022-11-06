//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Lloyd Mashumba on 3/11/2022.
//

import XCTest

class test_when_dashboard_succefully_load: XCTestCase {
    
    private var dashboardElements : DashboardElements!
    
    override func setUp() {
        let app =  XCUIApplication()
        continueAfterFailure = false
        dashboardElements = DashboardElements(app: app)
        app.launch()
        _ = dashboardElements.temperature.waitForExistence(timeout: 5)
    }
    
    func test_when_current_weather_successfully_loads(){
        
        let temp = dashboardElements.temperature.label
        XCTAssertEqual("26.88º", temp)
        
        let condition = dashboardElements.weatherCondition.label
        XCTAssertEqual("Rainny", condition)
        
        let currentTemp = dashboardElements.tempCurrent.label
        XCTAssertEqual("26.88º", currentTemp)
        
        let tempMin = dashboardElements.tempMin.label
        XCTAssertEqual("26.88º", tempMin)
        
        let tempMax = dashboardElements.tempMax.label
        XCTAssertEqual("26.88º", tempMax)
        
    }
}
