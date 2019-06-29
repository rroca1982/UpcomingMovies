//
//  NetworkError.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/28/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case lostConnection
    case invalidAPIKey
    case notFound
    case unknownError
}
