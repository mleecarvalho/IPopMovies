//
//  Movie.swift
//  IPopMovies
//
//  Created by Marcio on 29/01/2018.
//  Copyright © 2018 Marcio. All rights reserved.
//

import Foundation

class Movie{
    var posterPath: String
    var adult: Bool
    var overview: String
    var releaseDate: String
    var id: Int
    var originalTitle: String
    var originalLanguage: String
    var title: String
    var backdropPath: String
    var popularity: Double
    var voteCount: Int
    var video: Bool
    var voteAverage: Double
    
    init(data: Data) {
   //    try JSONDecoder().decode(self, from: data)
    }
}
