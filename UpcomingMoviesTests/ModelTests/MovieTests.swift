//
//  MovieTests.swift
//  UpcomingMoviesTests
//
//  Created by Rodolfo Roca on 6/28/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class MovieTests: XCTestCase {
    var decoder: JSONDecoder!
    
    var simpleMovieLocalJsonData: Data!
    var completeMovieLocalJsonData: Data!
    var movieCorruptedJsonData: Data!
    var movieNoImageJsonData: Data!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        
        setupJson(resource: "simpleMovieSample")
        setupJson(resource: "completeMovieSample")
        setupJson(resource: "movieSampleNullImages")
        setupJson(resource: "movieSampleCorrupted")
    }
    
    func setupJson(resource: String) {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                switch resource {
                case "simpleMovieSample":
                    simpleMovieLocalJsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    
                case "completeMovieSample":
                    completeMovieLocalJsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    
                case "movieSampleNullImages":
                    movieNoImageJsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    
                case "movieSampleCorrupted":
                    movieCorruptedJsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    
                default:
                    break
                }
            } catch {
                print("Error parsing no image json")
            }
        }
    }
    
    override func tearDown() {
        decoder = nil
        
        simpleMovieLocalJsonData = nil
        completeMovieLocalJsonData = nil
        movieCorruptedJsonData = nil
        movieNoImageJsonData = nil
        
        super.tearDown()
    }
    
    func testInitWithSimpleLocalData() {
        // given
        let movie = try? decoder.decode(Movie.self, from: simpleMovieLocalJsonData)
        
        // then
        XCTAssertNotNil(movie)
        XCTAssertNotNil(movie?.id)
    }
    
    func testInitWithCompleteLocalData() {
        // given
        let movie = try? decoder.decode(Movie.self, from: completeMovieLocalJsonData)
        
        // then
        XCTAssertNotNil(movie)
        XCTAssertNotNil(movie?.id)
    }
    
    func testInitWithSimpleAPIData() {
        // given
        let movie = try? decoder.decode(Movie.self, from: simpleMovieLocalJsonData)
        
        // then
        XCTAssertNotNil(movie)
        XCTAssertNotNil(movie?.id)
    }
    
    func testInitFail() {
        // given
        let movie = try? decoder.decode(Movie.self, from: movieCorruptedJsonData)
        
        // then
        XCTAssertNil(movie)
        XCTAssertNil(movie?.id)
    }
    
    func testInitWithNoImages() {
        // given
        let movie = try? decoder.decode(Movie.self, from: movieNoImageJsonData)
        
        // then
        XCTAssertNotNil(movie)
        XCTAssertNotNil(movie?.id)
        XCTAssertNil(movie?.posterPath)
        XCTAssertNil(movie?.backdropPath)
        XCTAssertNil(movie?.overview)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
