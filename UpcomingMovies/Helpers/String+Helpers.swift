//
//  String+Helpers.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
