//
//  File.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/28/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

struct GenreCollection: Codable {
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.genres = try valueContainer.decode([Genre].self, forKey: CodingKeys.genres)
    }
}
