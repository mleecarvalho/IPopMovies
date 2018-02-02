//
//  DashboardContract.swift
//  IPopMovies
//
//  Created by Marcio on 30/01/2018.
//  Copyright © 2018 Marcio. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardViewContract{
        func showLoading()
        func openItem(movie: Movie)
        func updateCollectionView()
}
    
protocol DashboardPresenterContract {
        func loadData(orderBy: MovieOrderBy)
        func reloadData(orderBy: MovieOrderBy)
        func getListMovie() -> [Movie]
        func getListMovieCount() -> Int
        func getMovie(index: Int) -> Movie
        func getOrderBy() -> MovieOrderBy
        func orderByWasChanged(orderBy: MovieOrderBy) -> Bool
        func getPicture(posterPath: String, movieImage: UIImageView, waitloadingView : UIActivityIndicatorView)
}

    

