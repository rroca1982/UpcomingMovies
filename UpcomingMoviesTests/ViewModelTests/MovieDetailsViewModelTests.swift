//
//  MovieDetailsViewModelTests.swift
//  UpcomingMoviesTests
//
//  Created by Rodolfo Roca on 6/30/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class MovieDetailsViewModelTests: XCTestCase {

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
    
    func testInitViewModelSuccessful() {
        // Given
        if let model = completeModel {
            let viewModel = MovieDetailsViewModel(model: model)
            
            // Then
            XCTAssertNotNil(viewModel)
        } else {
            XCTFail("Model is nil")
        }
    }
    
    func testAllAtributesTrueFromModel() {
        // Given
        if let model = completeModel {
            let viewModel = MovieDetailsViewModel(model: model)
            
            // Then
            XCTAssertEqual(viewModel.movieTitle, "Star Wars: The Last Jedi")
            
            let dateFormatter = DateFormatter.init()
            dateFormatter.dateStyle = .medium
            
            XCTAssertEqual(viewModel.releaseDate, "December 13, 2017")
            
            XCTAssertEqual(viewModel.posterImageURL, URL.init(string: "https://image.tmdb.org/t/p/w300/kOVEVeg59E0wsnXmF9nrh6OmWII.jpg")!)
            
            XCTAssertEqual(viewModel.posterPlaceholderImage, UIImage.init(named: "posterPlaceholderLarge"))
            
            XCTAssertEqual(viewModel.backdropImageURL, URL.init(string: "https://image.tmdb.org/t/p/w780/5Iw7zQTHVRBOYpA0V6z0yypOPZh.jpg")!)
            
            XCTAssertEqual(viewModel.backdropPlaceholderImage, UIImage.init(named: "backdropPlaceholderLarge"))
            
            XCTAssertEqual(viewModel.overview, "Rey develops her newly discovered abilities with the guidance of Luke Skywalker, who is unsettled by the strength of her powers. Meanwhile, the Resistance prepares to do battle with the First Order.")
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
