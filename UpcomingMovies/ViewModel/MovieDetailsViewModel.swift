//
//  MovieDetailsViewModel.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/30/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation
import UIKit

struct MovieDetailsViewModel {
    var movieTitle: String
    var posterImageURL: URL?
    let posterPlaceholderImage: UIImage! = UIImage.init(named: "posterPlaceholderLarge")
    var backdropImageURL: URL?
    let backdropPlaceholderImage: UIImage! = UIImage.init(named: "backdropPlaceholderLarge")
    var releaseDate: String
    var overview: String?
    
    init(model: Movie) {
        self.movieTitle = model.title
        
        self.releaseDate = MovieDetailsViewModel.setupReleaseDate(model.releaseDate)
        
        if let posterPath = model.posterPath {
            self.posterImageURL = URL.init(string: "https://image.tmdb.org/t/p/w300" + posterPath)
        }
        
        if let backdropPath = model.backdropPath {
            self.backdropImageURL = URL.init(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        }
        
        if let overview = model.overview {
            self.overview = overview
        } else {
            self.overview = "This movie does not have a synopsis yet".localized()
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
