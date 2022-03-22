//
//  DostoevskyUITests.swift
//  DostoevskyUITests
//
//  Created by Julian Gierl on 14.03.22.
//

import XCTest

class DostoevskyUITests: XCTestCase {
  
  
  override func setUp() {
    super.setUp()
    let app = XCUIApplication()
    setupSnapshot(app)
    app.launch()
  }
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  
  
  func testMapScreenShot() throws{
    
    
    let app = XCUIApplication()
    let button = app.scrollViews.otherElements.buttons["2, Серапинская гостиница, Май 1837"]
    button.tap()
    
    let element = app.tables.cells["2, Серапинская гостиница, Май 1837"].children(matching: .other).element(boundBy: 0).children(matching: .other).element
    element.tap()
    button.tap()
    button.tap()
    element.tap()
    let app = XCUIApplication()
    app.scrollViews.otherElements.buttons["2, Serapinskaya Hotel, May 1837"].tap()
    snapshot("01")
    app.buttons["Close"].tap()
    snapshot("02")
    let tabBar = app.tabBars["Tab Bar"]
    tabBar.buttons["Books"].tap()
    snapshot("03")
    tabBar.buttons["Map"].tap()
    snapshot("04")
    
    
  }
  
  
}
