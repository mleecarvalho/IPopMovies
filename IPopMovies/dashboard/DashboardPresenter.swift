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
            // Operation 2
            let requestsOnHoldQueue = OperationQueue() // new Queue
            requestsOnHoldQueue.addOperation({
                self.apiConnection.requestMovies(type: self.orderBy, listener: self)
                print("Operation 2")
            });

        }
    }
    
    func reloadData(orderBy: MovieOrderBy) {
        apiConnection.requestMovies(type: orderBy, listener: self )
    }
    
    func getMovie(index: Int) -> Movie{
        return self.movies[index]
    }
    
    func getListMovie() -> [Movie] {
        return self.movies
    }
    
    func getOrderBy(svdOb: Int) -> MovieOrderBy {
        
        for orderBy in SearchUtils.iterateEnum(MovieOrderBy.self) {
            if orderBy.rawValue == svdOb {
                return orderBy
            }
        }
        
        return MovieOrderBy.POPULARITY
    }
    
    func getPicture(posterPath: String, movieImage: UIImageView) {
        apiConnection.getMovieImage(imageView: movieImage, imagePath: posterPath)
    }
    
    func getListMovieCount() -> Int {
        return self.movies.count
    }
    
    func updateMovies(movies: [Movie]) {
        self.movies = movies
        view?.updateCollectionView()
    }
    

}
