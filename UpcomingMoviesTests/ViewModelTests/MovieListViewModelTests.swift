//
//  MovieListViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class MovieListViewModelTests: XCTestCase {
    var completeModel: Movie?

    override func setUp() {
        super.setUp()
        
        let decoder = JSONDecoder()
        
        if let completePath = Bundle.main.path(forResource: "completeMovieSample", ofType: "json") {
            do {
                let fullData = try Data(contentsOf: URL(fileURLWithPath: completePath), options: .mappedIfSafe)
                completeModel = try? decoder.decode(Movie.self, from: fullData)
            } catch {
                print("Error initializing model")
            }
        }
    }

    override func tearDown() {
        completeModel = nil
        
        super.tearDown()
    }

    func testAddMoviesSuccessful() {
        // Given
        if let model = completeModel {
            let viewModel = MovieListViewModel()
            
            var movies: [Movie] = [Movie]()
            movies.append(model)
            
            viewModel.addMovies([model])
            
            // Then
            XCTAssertNotNil(viewModel)
            XCTAssertEqual(viewModel.movies.count, 1)
        } else {
            XCTFail("Model is nil")
        }
    }
    
    func testNumberOfRowsSuccessful() {
        // Given
        if let model = completeModel {
            let viewModel = MovieListViewModel()
            
            var movies: [Movie] = [Movie]()
            movies.append(model)
            
            viewModel.addMovies([model])
            
            // Then
            XCTAssertNotNil(viewModel)
            XCTAssertEqual(viewModel.movies.count, viewModel.numberOfRows(0))
        } else {
            XCTFail("Model is nil")
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
