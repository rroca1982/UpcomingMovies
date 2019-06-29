//
//  GenreTests.swift
//  UpcomingMoviesTests
//
//  Created by Rodolfo Roca on 6/28/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import XCTest
@testable import UpcomingMovies

class GenreTests: XCTestCase {
    var decoder: JSONDecoder!
    var genreJsonData: Data!
    
    override func setUp() {
        super.setUp()
        
        decoder = JSONDecoder()
        if let path = Bundle.main.path(forResource: "simpleGenreSample", ofType: "json") {
            do {
                genreJsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                print("Error parsing no image json")
            }
        }
    }
    
    override func tearDown() {
        decoder = nil
        genreJsonData = nil
        super.tearDown()
    }
    
    func testInitWithSimpleLocalData() {
        let genre = try? decoder.decode(Genre.self, from: genreJsonData)
        
        // then
        XCTAssertNotNil(genre)
    }
    
    func testEquals() {
        let genreOne = try? decoder.decode(Genre.self, from: genreJsonData)
        let genreTwo = try? decoder.decode(Genre.self, from: genreJsonData)
        
        // then
        XCTAssertEqual(genreOne, genreTwo)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
