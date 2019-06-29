//
//  MovieCollection.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/28/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

struct MovieCollection: Decodable {
    var page: Int
    var totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.page = try valueContainer.decode(Int.self, forKey: CodingKeys.page)
        self.totalPages = try valueContainer.decode(Int.self, forKey: CodingKeys.totalPages)
        
        self.results = try valueContainer.decode([Movie].self, forKey: CodingKeys.results)
    }
}
