//
//  MovieListViewModel.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

class MovieListViewModel {
    private(set) var movies = [Movie]()
    
    func addMovies(_ movies: [Movie]) {
        self.movies.append(contentsOf: movies)
    }
    
    func removeAllMovies() {
        movies.removeAll()
    }
    
    func numberOfRows(_ section: Int) -> Int {
        return movies.count
    }

    func modelAt(_ index: Int) -> Movie {
        return movies[index]
    }
}
