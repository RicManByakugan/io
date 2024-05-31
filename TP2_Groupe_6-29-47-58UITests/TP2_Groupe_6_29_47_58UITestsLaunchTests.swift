//
//  TP2_Groupe_6_29_47_58UITestsLaunchTests.swift
//  TP2_Groupe_6-29-47-58UITests
//
//  Created by Fancisco Noam on 27/05/2024.
//

import XCTest

final class TP2_Groupe_6_29_47_58UITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
