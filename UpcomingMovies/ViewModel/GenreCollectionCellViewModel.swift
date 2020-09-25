//
//  GenreCollectionCellViewModel.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/30/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation
import UIKit

struct GenreCollectionCellViewModel {
    var name: String
    var labelBackgroundColor: UIColor
    var textColor: UIColor

    init(model: Genre) {
        name = model.name
        labelBackgroundColor = .randomColor
        textColor = .white
    }
}
