//
//  Date+Helpers.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 7/1/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToReleaseDateString() -> String {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateStyle = .long
        
        return dateFormatter.string(from: self)
    }
}
