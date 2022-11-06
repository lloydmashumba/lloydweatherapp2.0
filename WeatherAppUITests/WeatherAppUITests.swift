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
        let tempDay1 = dashboardElements.tempDay1.label
        XCTAssertEqual("Monday", day1)
        XCTAssertEqual("19.37º", tempDay1)
        //day2 tests
        let day2 = dashboardElements.day2.label
        let tempDay2 = dashboardElements.tempDay2.label
        XCTAssertEqual("Tuesday", day2)
        XCTAssertEqual("19.19º", tempDay2)
        //day3 tests
        let day3 = dashboardElements.day3.label
        let tempDay3 = dashboardElements.tempDay3.label
        XCTAssertEqual("Wednesday", day3)
        XCTAssertEqual("19.72º", tempDay3)
        //day4 tests
        let day4 = dashboardElements.day4.label
        let tempDay4 = dashboardElements.tempDay4.label
        XCTAssertEqual("Thursday", day4)
        XCTAssertEqual("16.91º", tempDay4)
        //day5 tests
        let day5 = dashboardElements.day5.label
        let tempDay5 = dashboardElements.tempDay5.label
        XCTAssertEqual("Friday", day5)
        XCTAssertEqual("20.37º", tempDay5)
    }
}
