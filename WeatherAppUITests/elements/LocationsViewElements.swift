//
//  LocationsViewElements.swift
//  WeatherAppUITests
//
//  Created by Lloyd Mashumba on 11/11/2022.
//

import Foundation
import XCTest

struct LocationsViewElement {
    let app : XCUIApplication
    
    var backFromNavigation : XCUIElement{
        app.navigationBars["WeatherApp.MapView"].buttons["Favourites"]
    }
    var backToDashboordNavigation : XCUIElement {
        app.navigationBars["Favourites"].buttons["Back"]
    }
    var firstLocationCell : XCUIElement{
        app.tables.cells.element(boundBy: 0)
    }
    var noFavouriteAlerts : XCUIElement {
        app.alerts["No Favourites"]
    }
}
