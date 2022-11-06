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
    
    func test_when_forecast_weather_successfully_loads(){
        //day1 tests
        let day1 = dashboardElements.day1.label
        let tempDay1 = dashboardElements.day1.label
        XCTAssertEqual("Sunday", day1)
        XCTAssertEqual("35º", day1)
        //day2 tests
        let day2 = dashboardElements.day2.label
        let tempDay2 = dashboardElements.day2.label
        XCTAssertEqual("Sunday", day2)
        XCTAssertEqual("35º", day2)
        //day3 tests
        let day3 = dashboardElements.day3.label
        let tempDay3 = dashboardElements.day3.label
        XCTAssertEqual("Sunday", day3)
        XCTAssertEqual("35º", day3)
        //day4 tests
        let day4 = dashboardElements.day4.label
        let tempDay4 = dashboardElements.day4.label
        XCTAssertEqual("Sunday", day4)
        XCTAssertEqual("35º", day4)
        //day5 tests
        let day5 = dashboardElements.day5.label
        let tempDay5 = dashboardElements.day5.label
        XCTAssertEqual("Sunday", day5)
        XCTAssertEqual("35º", day5)
    }
}
