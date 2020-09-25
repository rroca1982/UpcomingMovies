//
//  InternalError.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/28/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

enum InternalError: Error {
    case decodingError
    case noDataError
    case urlBuildingError
    case validationError
    case unknownError
}
