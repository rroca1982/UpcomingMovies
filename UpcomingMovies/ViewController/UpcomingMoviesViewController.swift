//
//  UpcomingMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/27/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import UIKit

class UpcomingMoviesViewController: UIViewController {

    @IBOutlet weak var failedFetchView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var movieListViewModel = MovieListViewModel()
    
    private var datasource: MovieListDataSource?
    
    private var page = 0
    private var totalPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Upcoming Movies".localized()
        
        navigationController?.navigationBar.barStyle = .blackOpaque
        
        datasource = MovieListDataSource(movieListViewModel, tableView: tableView)
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.tableFooterView = UIView.init(frame: .zero)

        activityIndicator.startAnimating()
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
                    if movieCollection.page == 1 && movieCollection.results.count == 0 {
                        self?.showFailedFetchView()
                    } else {
                        self?.movieListViewModel.addMovies(movieCollection.results)
                        self?.page = movieCollection.page
                        self?.totalPages = movieCollection.totalPages
                        self?.tableView.reloadData()
                    }
                case .Failure(let error):
                    if let strongSelf = self {
                        ErrorHandler.sharedInstance.handleError(error, from:    strongSelf)
                        if self?.movieListViewModel.movies.count == 0 {
                            self?.showFailedFetchView()
                        }
                    }
                }
                self?.activityIndicator.stopAnimating()
            }
            
        }
        
    }
    
    @IBAction func retryButtonTapped(_ sender: UIButton) {
        hideFailedFetchView()
        fetchUpcomingMovies(fromService: MovieService())
    }
    
    func showFailedFetchView() {
        tableView.isHidden = true
        failedFetchView.isHidden = false
    }
    
    func hideFailedFetchView() {
        failedFetchView.isHidden = true
        tableView.isHidden = false
        activityIndicator.startAnimating()
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
