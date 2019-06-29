//
//  MovieServiceTests.swift
//  UpcomingMoviesTests
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import XCTest

@testable import UpcomingMovies

class MovieServiceTests: XCTestCase {
    var movieService: MovieService!
    
    override func setUp() {
        super.setUp()
        movieService = MovieService()
    }
    
    override func tearDown() {
        movieService = nil
        super.tearDown()
    }
    
    func testFetchUpcomingCompletes() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        movieService.fetchUpcomingMovies(page: 1) { (result) in
            // Then
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchUpcomingGetsSuccessResult() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        movieService.fetchUpcomingMovies(page: 1) { (result) in
            switch result {
            case .Success(let movies):
                XCTAssertNotNil(movies)
                
                promise.fulfill()
            case .Failure:
                XCTFail()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchMovieDetailsCompletes() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        let avengersID = 299536
        let appends = "credits,release_dates"
        movieService.fetchMovieDetails(withID: avengersID, append: appends) { (result) in
            // Then
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchMovieDetailsGetsSuccessResult() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        let avengersID = 299536
        let appends = "credits,release_dates"
        movieService.fetchMovieDetails(withID: avengersID, append: appends) { (result) in
            switch result {
            case .Success(let movies):
                XCTAssertNotNil(movies)
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
