//
//  GenresDataSource.swift
//  UpcomingMovies
//
//  Created by Rodolfo Roca on 6/30/19.
//  Copyright © 2019 Rodolfo Roca. All rights reserved.
//

import Foundation
import UIKit

class GenresDataSource: NSObject, UICollectionViewDataSource {
    
    private var genresViewModel: GenresViewModel
    
    init(_ genresViewModel: GenresViewModel, collectionView: UICollectionView) {
        self.genresViewModel = genresViewModel
        
        collectionView.register(GenreCollectionViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genresViewModel.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GenreCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        
        let genre = genresViewModel.modelAt(indexPath.item)
        let viewModel = GenreCollectionCellViewModel.init(model: genre)
        cell.update(with: viewModel)
        
        return cell
    }
}
