//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by User on 10.05.2023.
//

import XCTest
@testable import ImageFeed

final class ImageFeedUITests: XCTestCase {

    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app.launch()
    }

    func testAuth() throws {
        app.buttons["Authenticate"].tap()
        
        let webView = app.webViews["UnsplashWebView"]
        
        XCTAssertTrue(webView.waitForExistence(timeout: 5
                                              ))
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))
        
        loginTextField.tap()
        loginTextField.typeText("fragnet1ck@gmail.com")
        loginTextField.swipeUp()
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))
        
        passwordTextField.tap()
        passwordTextField.typeText("MonkeysArctic007071")
        loginTextField.swipeUp()
        
        app.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        sleep(5)
        print(app.debugDescription)
        
    }
    
    func testFeed() {
        let tableQuery = app.tables
        let cell = tableQuery.children(matching: .cell).element(boundBy: 0)
        cell.swipeUp()
        
        sleep(2)
        
        let cellToLike = tableQuery.children(matching: .cell).element(boundBy: 1)
        
        cellToLike.buttons["likeButton"].tap()
        cellToLike.buttons["likeButton"].tap()
        
        sleep(2)
        
        cellToLike.tap()
        sleep(5)
        
        let image = app.scrollViews.images.element(boundBy: 0)
        
        
        image.pinch(withScale: 3, velocity: 1)
    
        image.pinch(withScale: 0.5, velocity: -1)
            
        let navBackButtonWhiteButton = app.buttons["navBackButton"]
            navBackButtonWhiteButton.tap()
        
    }
   
    func testProfile() {
        sleep(3)
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.staticTexts["Anton Litvinov"].exists)
        XCTAssertTrue(app.staticTexts["@udachi_tomo"].exists)
        
        app.buttons["logoutButton"].tap()
        
        app.alerts["Выход"].scrollViews.otherElements.buttons["Да"].tap()
    }
}
