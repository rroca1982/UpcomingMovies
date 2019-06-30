//
//  SearchMoviesViewController.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/30/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import UIKit

class SearchMoviesViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noResultsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var isSearching = false
    
    private var movieListViewModel = MovieListViewModel()
    
    private var datasource: MovieListDataSource?
    
    private var page = 0
    private var totalPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search Movies".localized()
        
        navigationController?.navigationBar.barStyle = .blackOpaque
        extendedLayoutIncludesOpaqueBars = true

        datasource = MovieListDataSource(movieListViewModel, tableView: tableView)
        tableView.dataSource = datasource
        tableView.delegate = self
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        setupSearchBarController()
        showNoResultsLabel()
    }
    
    fileprivate func setupSearchBarController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        
        let searchBar = searchController.searchBar
        searchBar.tintColor = UIColor.white
        searchBar.delegate = self
        searchBar.placeholder = "Find movies by their title".localized()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func search(searchTerm: String) {
        isSearching = true

        page = 0
        totalPages = 1
        movieListViewModel.removeAllMovies()

        hideNoResultsLabel()
        
        activityIndicator.startAnimating()
        
        searchMovies(searchTerm: searchTerm, fromService: SearchService())
    }
    
    @objc func clearSearch() {
        isSearching = false
        
        movieListViewModel.removeAllMovies()
        tableView.reloadData()

        showNoResultsLabel()
        
        page = 0
        totalPages = 1
    }
    
    func searchMovies<S: Gettable>(searchTerm: String, fromService service: S) {
        guard let service = service as? SearchService else {
            return
        }
        
        service.searchMoviesByTitle(searchTerm: searchTerm, page: (page + 1)) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .Success(let movieCollection):
                    if movieCollection.page == 1 && movieCollection.results.count == 0 {
                        self?.showNoResultsLabel()
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
                            self?.hideNoResultsLabel()
                        }
                    }
                }
                self?.activityIndicator.stopAnimating()
            }
        }
        
    }
    
    func showNoResultsLabel() {
        tableView.isHidden = true
        noResultsLabel.isHidden = false
        
        updateNoResultsLabelText()
    }
    
    func hideNoResultsLabel() {
        noResultsLabel.isHidden = true
        tableView.isHidden = false
    }
    
    fileprivate func updateNoResultsLabelText() {
        if isSearching {
            noResultsLabel.text = "No results found".localized()
        } else {
            noResultsLabel.text = "Search for movies by its' title.".localized()
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.movieDetailsFromSearch.rawValue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as! MovieDetailsViewController
                destination.movie = movieListViewModel.movies[indexPath.row]
            }
        }
    }
}

// MARK: - SearchBar Delegates
extension SearchMoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }

        if text != "" {
            search(searchTerm: text)
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch()
    }
}

extension SearchMoviesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if isSearching {
            if page < totalPages {
                if indexPath.item == movieListViewModel.movies.count - 1 {
                    if let searchTerm = navigationItem.searchController?.searchBar.text, searchTerm != "" {
                        searchMovies(searchTerm: searchTerm, fromService: SearchService())
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: .movieDetailsFromSearch, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchMoviesViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case movieDetailsFromSearch
    }
}
