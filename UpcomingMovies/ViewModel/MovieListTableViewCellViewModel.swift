//
//  MovieListTableViewCellViewModel.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation
import UIKit

struct MovieListTableViewCellViewModel {
    var movieTitle: String
    var posterImageURL: URL?
    let posterPlaceholderImage = UIImage.init(named: "posterPlaceholderLarge")
    var releaseDate: String
    var genre: String?
    
    init(model: Movie) {
        self.movieTitle = model.title
        
        self.releaseDate = MovieListTableViewCellViewModel.setupReleaseDate(model.releaseDate)
        
        if let posterPath = model.posterPath {
            self.posterImageURL = URL.init(string: "https://image.tmdb.org/t/p/w300" + posterPath)
        }
        
        if model.genres.count > 0 {
            genre = model.genres.first?.name
        }
    }
    
    private static func setupReleaseDate(_ date: Date?) -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateStyle = .long
        
        if let date = date {
            return dateFormatter.string(from: date)
        }
        return "Unknown release date"
    }
}
