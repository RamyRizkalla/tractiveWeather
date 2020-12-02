//  Copyright © 2020 Tractive. All rights reserved.

import XCTest

enum WeatherElements {
    private static let app = XCUIApplication()

    static var cityLabel: XCUIElement {
        return cell(at: 0).staticTexts["cityLabel"]
    }

    static var weatherStatusLabel: XCUIElement {
        return cell(at: 0).staticTexts["weatherStatusLabel"]
    }

    static var temperatureLabel: XCUIElement {
        return cell(at: 0).staticTexts["temperatureLabel"]
    }

    static var humidityHeaderLabel: XCUIElement {
        return cell(at: 2).staticTexts["humidityHeaderLabel"]
    }

    static var windHeaderLabel: XCUIElement {
        return cell(at: 2).staticTexts["windHeaderLabel"]
    }

    static func cell(at index: Int) -> XCUIElement {
        return app.cells.element(boundBy: index)
    }

    static var tableView: XCUIElement {
        return app.tables.firstMatch
    }

    static var cells: XCUIElementQuery {
        return tableView.cells
    }
}

class WeatherTests: XCTestCase {
    override func setUp() {
        let app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    func testExample() {
        XCTAssert(WeatherElements.cityLabel.exists)
        XCTAssert(WeatherElements.weatherStatusLabel.exists)
        XCTAssert(WeatherElements.temperatureLabel.exists)
        XCTAssert(WeatherElements.humidityHeaderLabel.exists)
        XCTAssert(WeatherElements.windHeaderLabel.exists)
    }
}
