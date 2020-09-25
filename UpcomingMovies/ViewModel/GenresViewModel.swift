//
//  GenresViewModel.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/30/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

class GenresViewModel {
    private(set) var genres = [Genre]()
    
    func addGenres(_ genres: [Genre]) {
        self.genres.append(contentsOf: genres)
    }
    
    func numberOfItems(_ section: Int) -> Int {
        return genres.count
    }
    
    func modelAt(_ index: Int) -> Genre {
        return genres[index]
    }
}
