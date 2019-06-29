//
//  AlertViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import XCTest

@testable import UpcomingMovies

class AlertViewModelTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitInternalErrorModelSuccessful() {
        // Given
        let noDataError = InternalError.noDataError
        let unknownError = InternalError.unknownError
        
        // When
        let noDataViewModel = AlertViewModel.init(model: noDataError)
        let unknownViewModel = AlertViewModel.init(model: unknownError)
        
        // Then
        XCTAssertNotNil(noDataViewModel)
        XCTAssertNotNil(unknownViewModel)
    }
    
    func testInitNetworkErrorModelSuccessful() {
        // Given
        let timeoutError = SwiftyRestKitError.timeout
        let lostConnectionError = SwiftyRestKitError.lostConnection
        let secureConnectionError = SwiftyRestKitError.secureConnectionFailed
        let badURLError = SwiftyRestKitError.badURL
        let hostNotFoundError = SwiftyRestKitError.hostNotFound
        let notFoundError = SwiftyRestKitError.resourceNotFound
        let unknownError = SwiftyRestKitError.unknownError
        
        // When
        let timeoutViewModel = AlertViewModel.init(model: timeoutError)
        let lostConnectionViewModel = AlertViewModel.init(model: lostConnectionError)
        let secureConnectionViewModel = AlertViewModel.init(model: secureConnectionError)
        let badURLViewModel = AlertViewModel.init(model: badURLError)
        let hostNotFoundViewModel = AlertViewModel.init(model: hostNotFoundError)
        let notFoundViewModel = AlertViewModel.init(model: notFoundError)
        let unknownViewModel = AlertViewModel.init(model: unknownError)
        
        // Then
        XCTAssertNotNil(timeoutViewModel)
        XCTAssertNotNil(lostConnectionViewModel)
        XCTAssertNotNil(secureConnectionViewModel)
        XCTAssertNotNil(badURLViewModel)
        XCTAssertNotNil(hostNotFoundViewModel)
        XCTAssertNotNil(notFoundViewModel)
        XCTAssertNotNil(unknownViewModel)
    }
    
    func testInitErrorModelSuccessful() {
        
        let defaultError = NSError.init(domain: "Unknown error", code: 0, userInfo: nil)
        
        // When
        let defaultViewModel = AlertViewModel.init(model: defaultError)
        
        // Then
        XCTAssertNotNil(defaultViewModel)
    }
    
    func testAllAtributesFromInternalErrorModel() {
        // Given
        let noDataError = InternalError.noDataError
        let unknownError = InternalError.unknownError
        
        // When
        let noDataViewModel = AlertViewModel.init(model: noDataError)
        let unknownViewModel = AlertViewModel.init(model: unknownError)
        
        // Then
        XCTAssertEqual(noDataViewModel.title, NSLocalizedString("notFoundAlertTitle", comment: "Not found"))
        XCTAssertEqual(noDataViewModel.message, NSLocalizedString("notFoundInternalErrorAlertMsg", comment: "Your request did not return any data."))
        
        XCTAssertEqual(unknownViewModel.title, NSLocalizedString("unknownErrorAlertTitle", comment: "Unknown error"))
        XCTAssertEqual(unknownViewModel.message, NSLocalizedString("unknownInternalErrorAlertMsg", comment: "An unknown internal error occured, please check your internet connection and pull to refresh to try again. If the error persists, please contact support."))
    }
    
    func testAllAtributesFromNetworkErrorModel() {
        // Given
        let timeoutError = SwiftyRestKitError.timeout
        let lostConnectionError = SwiftyRestKitError.lostConnection
        let secureConnectionError = SwiftyRestKitError.secureConnectionFailed
        let badURLError = SwiftyRestKitError.badURL
        let hostNotFoundError = SwiftyRestKitError.hostNotFound
        let notFoundError = SwiftyRestKitError.resourceNotFound
        let unknownError = SwiftyRestKitError.unknownError
        
        // When
        let timeoutViewModel = AlertViewModel.init(model: timeoutError)
        let lostConnectionViewModel = AlertViewModel.init(model: lostConnectionError)
        let secureConnectionViewModel = AlertViewModel.init(model: secureConnectionError)
        let badURLViewModel = AlertViewModel.init(model: badURLError)
        let hostNotFoundViewModel = AlertViewModel.init(model: hostNotFoundError)
        let notFoundViewModel = AlertViewModel.init(model: notFoundError)
        let unknownViewModel = AlertViewModel.init(model: unknownError)
        
        // Then
        XCTAssertEqual(timeoutViewModel.title, NSLocalizedString("timeoutAlertTitle", comment: "Connection Timeout"))
        XCTAssertEqual(timeoutViewModel.message, NSLocalizedString("timeoutAlertMsg", comment: "The connection timed out, please check your internet connection and try again."))
        
        XCTAssertEqual(lostConnectionViewModel.title, NSLocalizedString("lostConnectionAlertTitle", comment: "Lost connection"))
        XCTAssertEqual(lostConnectionViewModel.message, NSLocalizedString("lostConnectionAlertMsg", comment: "You are not connected to the Internet, please check your connection and pull to refresh to try again."))
        
        XCTAssertEqual(secureConnectionViewModel.title, NSLocalizedString("secureConnectionAlertTitle", comment: "Could not establish connection"))
        XCTAssertEqual(secureConnectionViewModel.message, NSLocalizedString("secureConnectionAlertMsg", comment: "We could not establish a secure connection to the server, please check your internet connection and try again. If the problem persists, please contact support."))
        
        XCTAssertEqual(notFoundViewModel.title, NSLocalizedString("notFoundAlertTitle", comment: "Not found"))
        XCTAssertEqual(notFoundViewModel.message, NSLocalizedString("notFoundAlertMsg", comment: "The resource you are trying to reach does not exist."))
        
        XCTAssertEqual(badURLViewModel.title, NSLocalizedString("badUrlAlertTitle", comment: "Bad URL"))
        XCTAssertEqual(badURLViewModel.message, NSLocalizedString("badUrlAlertMsg", comment: "There is something wrong with the URL you are trying to access. Please try again in a few minutes or contact support if the problem persists."))
        
        XCTAssertEqual(hostNotFoundViewModel.title, NSLocalizedString("hostNotFoundAlertTitle", comment: "Server not found"))
        XCTAssertEqual(hostNotFoundViewModel.message, NSLocalizedString("hostNotFoundAlertMsg", comment: "We could not establish a connection to the server, please check your internet connection and try again. If the problem persists, please contact support."))
        
        XCTAssertEqual(unknownViewModel.title, NSLocalizedString("unknownErrorAlertTitle", comment: "Unknown error"))
        XCTAssertEqual(unknownViewModel.message, NSLocalizedString("unknownNetworkErrorAlertMsg", comment: "An unknown network error occured, please check your internet connection and pull to refresh to try again. If the error persists, please contact support."))
    }
    
    func testAllAtributesFromErrorModel() {
        let defaultError = NSError.init(domain: "Unknown error", code: 0, userInfo: nil)
        
        // When
        let defaultViewModel = AlertViewModel.init(model: defaultError)
        
        // Then
        XCTAssertEqual(defaultViewModel.title, NSLocalizedString("unknownErrorAlertTitle", comment: "Unknown error"))
        XCTAssertEqual(defaultViewModel.message, NSLocalizedString("unknownInternalErrorAlertMsg", comment: "An unknown internal error occured, please check your internet connection and pull to refresh to try again. If the error persists, please contact support."))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

