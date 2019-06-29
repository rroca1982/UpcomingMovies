//
//  GenreServiceTests.swift
//  UpcomingMoviesTests
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class GenreServiceTests: XCTestCase {
    var genreService: GenreService!
    
    override func setUp() {
        super.setUp()
        genreService = GenreService()
    }
    
    override func tearDown() {
        genreService = nil
        super.tearDown()
    }
    
    // MARK: - Test Get Genres
    func testFetchGenresCompletes() {
        // given
        let promise = expectation(description: "Completion handler invoked")
        
        // when
        genreService.fetchGenres { (result) in
            // Then
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchGenresGetsSuccessResult() {
        // given
        let promise = expectation(description: "Status code: 200")
        
        // when
        genreService.fetchGenres { (result) in
            switch result {
            case .Success(let genres):
                XCTAssertNotNil(genres)
                
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
