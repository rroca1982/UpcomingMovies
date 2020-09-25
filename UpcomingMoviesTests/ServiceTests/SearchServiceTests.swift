//
//  SearchServiceTests.swift
//  UpcomingMoviesTests
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import XCTest

@testable import UpcomingMovies

class SearchServiceTests: XCTestCase {
    var searchService: SearchService!
    
    override func setUp() {
        super.setUp()
        searchService = SearchService()
    }
    
    override func tearDown() {
        searchService = nil
        super.tearDown()
    }
    
    func testSearchMoviesCompletes() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        let searchTerm = "Star"
        searchService.searchMoviesByTitle(searchTerm: searchTerm, page: 1) { (result) in
            // Then
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchMoviesGetsSuccessResult() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        let searchTerm = "Star"
        searchService.searchMoviesByTitle(searchTerm: searchTerm, page: 1) { (result) in            switch result {
        case .Success(let movieCollection):
            XCTAssertNotNil(movieCollection)
            
            promise.fulfill()
        case .Failure:
            XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

