//
//  Movie.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/27/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var id: Int
    var title: String
    var popularity: Double?
    var releaseDate: Date?
    var runtime: Int?
    var userScore: Double
    var posterPath: String?
    var backdropPath: String?
    var genres: [Genre] = [Genre]()
    var overview: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case popularity
        case releaseDate = "release_date"
        case runtime
        case userScore = "vote_average"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genres
        case genreIDs = "genre_ids"
        case overview
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        
        self.popularity = try? valueContainer.decode(Double.self, forKey: CodingKeys.popularity)
        
        let dateString = try? valueContainer.decode(String.self, forKey: CodingKeys.releaseDate)
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.isLenient = true
        if let dateString = dateString, dateString != "" {
            self.releaseDate = dateFormatter.date(from: dateString)!
        }
        
        self.runtime = try? valueContainer.decode(Int.self, forKey: CodingKeys.runtime)
        self.userScore = try valueContainer.decode(Double.self, forKey: CodingKeys.userScore)
        
        self.posterPath = try? valueContainer.decode(String.self, forKey: CodingKeys.posterPath)
        self.backdropPath = try? valueContainer.decode(String.self, forKey: CodingKeys.backdropPath)
        
        if let genreIDs = try? valueContainer.decode([Int].self, forKey: CodingKeys.genreIDs) {
            for id in genreIDs {
                for genre in AppDelegate.allGenres {
                    if id == genre.id {
                        self.genres.append(genre)
                        break
                    }
                }
            }
        } else {
            self.genres = try valueContainer.decode([Genre].self, forKey: CodingKeys.genres)
        }
        
        self.overview = try? valueContainer.decode(String.self, forKey: CodingKeys.overview)
    }
}
