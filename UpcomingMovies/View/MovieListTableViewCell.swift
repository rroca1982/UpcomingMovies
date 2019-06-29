//
//  MovieListTableViewCell.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/29/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var posterHoldingView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var genreHoldingView: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let posterCornerRadius = CGFloat(6.0)
        posterHoldingView.addDefaultPosterShadow()
        posterImageView.layer.cornerRadius = posterCornerRadius
        
        let genreCornerRadius = CGFloat(genreHoldingView.frame.height / 2)
        genreHoldingView.layer.cornerRadius = genreCornerRadius
        genreHoldingView.backgroundColor = UIColor.randomColor
        
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    func update(with viewModel: MovieListTableViewCellViewModel) {
        if let posterImageURL = viewModel.posterImageURL {
            posterImageView.setImage(withURL: posterImageURL.absoluteString, placeholderImage: viewModel.posterPlaceholderImage!)
        } else {
            posterImageView.image = viewModel.posterPlaceholderImage!
        }
        
        movieTitleLabel.text = viewModel.movieTitle
        releaseDateLabel.text = viewModel.releaseDate
        
        if let genre = viewModel.genre {
            genreLabel.text = genre
        } else {
            genreHoldingView.isHidden = true
        }
    }
}

extension MovieListTableViewCell: ReusableView, NibLoadableView { }
