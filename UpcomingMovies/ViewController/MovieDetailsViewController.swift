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
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextLabel: UILabel!
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Details".localized()
        
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
        
        genreLabel.text = viewModel.genre
        releaseDateLabel.text = NSLocalizedString("releaseDate", comment: "Release date: ") + viewModel.releaseDate
        overviewTextLabel.text = viewModel.overview
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
