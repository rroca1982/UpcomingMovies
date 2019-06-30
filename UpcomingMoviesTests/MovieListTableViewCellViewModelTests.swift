//
//  MovieListTableViewCellViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class MovieListTableViewCellViewModelTests: XCTestCase {
    
    var completeModel: Movie?
    var incompleteModel: Movie?
    
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
        
        if let incompletePath = Bundle.main.path(forResource: "movieSampleNullImages", ofType: "json") {
            do {
                let fullData = try Data(contentsOf: URL(fileURLWithPath: incompletePath), options: .mappedIfSafe)
                incompleteModel = try? decoder.decode(Movie.self, from: fullData)
            } catch {
                print("Error initializing model")
            }
        }
    }
    
    override func tearDown() {
        completeModel = nil
        incompleteModel = nil
        
        super.tearDown()
    }
    
    func testInitCompleteModelSuccessful() {
        // Given
        if let model = completeModel {
            let viewModel = MovieListTableViewCellViewModel(model: model)
            
            // Then
            XCTAssertNotNil(viewModel)
        } else {
            XCTFail("Model is nil")
        }
    }
    
    func testInitIncompleteModelSuccessful() {
        // Given
        if let model = incompleteModel {
            let viewModel = MovieListTableViewCellViewModel(model: model)

            // Then
            XCTAssertNotNil(viewModel)
        } else {
            XCTFail("Model is nil")
        }
    }
    
    func testAllAtributesTrueFromModel() {
        // Given
        if let model = completeModel {
            let viewModel = MovieListTableViewCellViewModel(model: model)

            // Then
            XCTAssertEqual(viewModel.movieTitle, "Star Wars: The Last Jedi")
            
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateStyle = .medium
            
            XCTAssertEqual(viewModel.releaseDate, "December 13, 2017")
            
            XCTAssertEqual(viewModel.posterImageURL, URL.init(string: "https://image.tmdb.org/t/p/w300/kOVEVeg59E0wsnXmF9nrh6OmWII.jpg")!)
            
            XCTAssertEqual(viewModel.posterPlaceholderImage, UIImage.init(named: "posterPlaceholderLarge"))
            
            XCTAssertEqual(viewModel.genre, "Fantasy")
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
