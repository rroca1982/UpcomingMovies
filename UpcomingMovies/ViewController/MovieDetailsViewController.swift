//
//  MovieDetailsViewController.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/30/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterHoldingView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var movie: Movie!
    
    private var datasource: GenresDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Details".localized()
        
        let posterCornerRadius = CGFloat(6.0)
        posterHoldingView.addDefaultPosterShadow()
        posterImageView.layer.cornerRadius = posterCornerRadius
        
        setupGenresCollectionView()
        setupMovieDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let size = collectionView.contentSize.height
        collectionViewHeightConstraint.constant = size
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: nil, completion: { _ in
            DispatchQueue.main.async { [weak self] in
                if let size = self?.collectionView.contentSize.height {
                    self?.collectionViewHeightConstraint.constant = size
                }
            }
            
        })
    }
    
    fileprivate func setupMovieDetails() {
        let viewModel = MovieDetailsViewModel.init(model: movie)
        
        if let backdropImageURL = viewModel.backdropImageURL {
            backdropImageView.setImage(withURL: backdropImageURL.absoluteString, placeholderImage: viewModel.backdropPlaceholderImage)
        } else {
            backdropImageView.image = viewModel.backdropPlaceholderImage
        }
        
        movieTitleLabel.text = viewModel.movieTitle
        
        if let posterImageURL = viewModel.posterImageURL {
            posterImageView.setImage(withURL: posterImageURL.absoluteString, placeholderImage: viewModel.posterPlaceholderImage)
        } else {
            posterImageView.image = viewModel.posterPlaceholderImage
        }
        
        releaseDateLabel.text = "Release date: ".localized() + viewModel.releaseDate
        overviewTextLabel.text = viewModel.overview
    }
    
    fileprivate func setupGenresCollectionView() {
        let viewModel = GenresViewModel()
        viewModel.addGenres(movie.genres)
        
        datasource = GenresDataSource(viewModel, collectionView: collectionView)
        collectionView.dataSource = datasource
        collectionView.delegate = self
    }
}

extension MovieDetailsViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewModel = GenreCollectionCellViewModel.init(model: movie.genres[indexPath.row])
        let size: CGSize = viewModel.name.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .medium)])
        return CGSize(width: size.width + 35.0, height: 25)
    }
}
