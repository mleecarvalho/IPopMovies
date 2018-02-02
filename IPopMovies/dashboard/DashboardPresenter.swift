//
//  DashboardPresenter.swift
//  IPopMovies
//
//  Created by Marcio on 30/01/2018.
//  Copyright © 2018 Marcio. All rights reserved.
//

import Foundation
import UIKit

class DashboardPresenter: DashboardPresenterContract, ResponseListener {

    private var movies: [Movie] = []
    private var view: DashboardViewContract?
    private let apiConnection: ApiConnection = ApiConnection()
    private var orderBy: MovieOrderBy = MovieOrderBy.POPULARITY
    
    init(view: DashboardViewContract) {
        self.view = view
    }

    func loadData(orderBy: MovieOrderBy) {
        if movies.isEmpty{
            let requestsOnHoldQueue = OperationQueue() // new Queue
            requestsOnHoldQueue.addOperation({
                self.apiConnection.requestMovies(type: self.orderBy, listener: self)
            });

        }
    }
    
    func reloadData(orderBy: MovieOrderBy) {
        self.orderBy = orderBy
        apiConnection.requestMovies(type: orderBy, listener: self )
    }
    
    func getMovie(index: Int) -> Movie{
        return self.movies[index]
    }
    
    func getListMovie() -> [Movie] {
        return self.movies
    }
    
    func getOrderBy() -> MovieOrderBy {
        return self.orderBy
    }
    
    func getPicture(posterPath: String, movieImage: UIImageView, waitloadingView : UIActivityIndicatorView) {
        apiConnection.getMovieImage(
            imageView: movieImage,
            imagePath: posterPath,
            waitloadingView : waitloadingView
        )
    }
    
    func getListMovieCount() -> Int {
        return self.movies.count
    }
    
    func updateMovies(movies: [Movie]) {
        self.movies = movies
        view?.updateCollectionView()
    }

    func orderByWasChanged(orderBy: MovieOrderBy) -> Bool {
        return self.orderBy != orderBy
    }

}
