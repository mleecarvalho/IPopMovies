//
//  DashboardPresenter.swift
//  IPopMovies
//
//  Created by Marcio on 30/01/2018.
//  Copyright © 2018 Marcio. All rights reserved.
//

import Foundation
import UIKit

class DashboardPresenter: DashboardPresenterContract {
    
    private var movies: [Movie] = [Movie]()
    private var view: DashboardViewContract?
    private let apiConnection: ApiConnection = ApiConnection()
    private var orderBy: MovieOrderBy = MovieOrderBy.POPULARITY
    
    init(view: DashboardViewContract) {
        self.view = view
    }

    func loadData(orderBy: MovieOrderBy) {
        if movies.isEmpty{
          self.movies = apiConnection.requestMovies(type: self.orderBy)
        } else {
            if self.view != nil {
                self.view!.fillList(movies: self.movies)
                
            }
        }
    }
    
    func reloadData(orderBy: MovieOrderBy) {
        self.movies = apiConnection.requestMovies(type: orderBy)
        self.view!.fillList(movies: self.movies)
    }
    
    func updateList(movies: [Movie]) {
        self.movies = movies
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
    

}
