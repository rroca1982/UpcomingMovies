//
//  UpcomingMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/27/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var movieListViewModel = MovieListViewModel()
    
    private var datasource: MovieListDataSource?
    
    private var page = 0
    private var totalPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datasource = MovieListDataSource(movieListViewModel, tableView: tableView)
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.tableFooterView = UIView.init(frame: .zero)

        fetchUpcomingMovies(fromService: MovieService())
    }

    func fetchUpcomingMovies<S: Gettable>(fromService service: S) {
        guard let service = service as? MovieService else {
            return
        }
        
        service.fetchUpcomingMovies(page: page+1) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .Success(let movieCollection):
                    self?.movieListViewModel.addMovies(movieCollection.results)
                    self?.page = movieCollection.page
                    self?.totalPages = movieCollection.totalPages
                    self?.tableView.reloadData()
                case .Failure(let error):
                    if let strongSelf = self {
                        ErrorHandler.sharedInstance.handleError(error, from:    strongSelf)
                    }
                }
            }
            
        }
        
    }
    
}

extension UpcomingMoviesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if page < totalPages {
            if indexPath.item == movieListViewModel.movies.count - 1 {
                fetchUpcomingMovies(fromService: MovieService())
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
