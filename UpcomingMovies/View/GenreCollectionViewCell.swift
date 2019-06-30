//
//  GenreCollectionViewCell.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/30/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var holdingView: UIView!
    @IBOutlet weak private var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let cornerRadius: CGFloat = self.frame.size.height / 2.0
        holdingView.layer.cornerRadius = cornerRadius
    }
    
    func update(with viewModel: GenreCollectionCellViewModel) {
        holdingView.backgroundColor = viewModel.labelBackgroundColor
        genreLabel.textColor = viewModel.textColor
        genreLabel.text = viewModel.name
    }
}

extension GenreCollectionViewCell: ReusableView, NibLoadableView { }
