//
//  Genre.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/27/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

struct Genre: Codable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
    }
}

extension Genre: Equatable {
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id
    }
}
