//  Copyright © 2020 Tractive. All rights reserved.

import XCTest

class WeatherTests: XCTestCase {
    override func setUp() {
        let app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    func testElementsExist() {
        XCTAssert(WeatherElements.cityLabel.exists)
        XCTAssert(WeatherElements.weatherStatusLabel.exists)
        XCTAssert(WeatherElements.temperatureLabel.exists)
        XCTAssert(WeatherElements.humidityHeaderLabel.exists)
        XCTAssert(WeatherElements.windHeaderLabel.exists)
    }
}
