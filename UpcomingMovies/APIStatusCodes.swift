//
//  APIStatusCodes.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/28/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

enum APIStatusCodes: Int {
    case success = 200
    case invalidAPIKey = 401
    case notFound = 404
}
