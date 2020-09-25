//
//  MovieListDataSource.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation
import UIKit

class MovieListDataSource: NSObject, UITableViewDataSource {
    
    private var movieListViewModel: MovieListViewModel
    
    init(_ movieListViewModel: MovieListViewModel, tableView: UITableView) {
        self.movieListViewModel = movieListViewModel
        
        tableView.register(MovieListTableViewCell.self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MovieListTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        
        let movie = movieListViewModel.modelAt(indexPath.row)
        let movieCellViewModel = MovieListTableViewCellViewModel.init(model: movie)
        
        cell.update(with: movieCellViewModel)
        
        return cell
    }
}
