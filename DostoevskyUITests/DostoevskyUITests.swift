//
//  DostoevskyUITests.swift
//  DostoevskyUITests
//
//  Created by Julian Gierl on 14.03.22.
//

import XCTest




class DostoevskyUITests: XCTestCase {
  
    
  func isRussian() -> Bool {
    return NSLocale.preferredLanguages[0].range(of:"ru") != nil
  }
  override func setUp() {
    super.setUp()
    let app = XCUIApplication()
    setupSnapshot(app)
    app.launchArguments.append("--UITests")
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
      app.launchArguments.append("--UITests")
      snapshot("00main")
      app.buttons[AccessibilityIdentifier.exploreButton].tap()
      
      app.scrollViews.otherElements.buttons.firstMatch.tap()
      snapshot("01")
      app.buttons[AccessibilityIdentifier.dismissButton].tap()
      snapshot("02")
      app.buttons[AccessibilityIdentifier.books].tap()
      snapshot("03")
      app.buttons[AccessibilityIdentifier.map].tap()
      snapshot("04")
  }
}


