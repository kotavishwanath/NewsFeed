//
//  NewsFeedUITests.swift
//  NewsFeedUITests
//
//  Created by Vishwanath on 11/08/21.
//

import XCTest

class NewsFeedUITests: XCTestCase {
    
    func testLoadingData() {
        let app = XCUIApplication()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element.swipeUp()
        app.buttons["https://www.welt.de/wirtschaft/article233094023/Elon-Musk-macht-Druck-beim-Zeitplan-fuer-Tesla-Fabrik-in-Gruenheide.html"].tap()
        
        let breadcrumbButton = app.statusBars/*@START_MENU_TOKEN@*/.buttons["breadcrumb"]/*[[".buttons[\"Return to NewsFeed\"]",".buttons[\"breadcrumb\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        breadcrumbButton.tap()
        
        let backButton = app.navigationBars["World News Feed"].buttons["Back"]
        backButton.tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["2021-08-12T10:36:00Z"]/*[[".cells.staticTexts[\"2021-08-12T10:36:00Z\"]",".staticTexts[\"2021-08-12T10:36:00Z\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["https://www.business-standard.com/article/automobile/tesla-files-to-produce-5-more-versions-of-model-y-suv-in-china-121081201035_1.html"].tap()
        breadcrumbButton.tap()
        backButton.tap()
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
