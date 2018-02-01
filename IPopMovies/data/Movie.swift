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
    
    init(data: [String: Any]) {
        posterPath = (data["poster_path"] as? String) ?? ""
        adult = (data["adult"] as? Bool) ?? false
        overview = (data["overview"] as? String) ?? ""
        releaseDate = (data["release_date"] as? String) ?? ""
        id = (data["id"] as? Int) ?? 0
        originalTitle = (data["original_title"] as? String) ?? ""
        originalLanguage = (data["original_language"] as? String) ?? ""
        title = (data["title"] as? String) ?? ""
        backdropPath = (data["backdrop_path"] as? String) ?? ""
        popularity = (data["popularity"] as? Double) ?? 0
        voteCount = (data["vote_count"] as? Int) ?? 0
        video = (data["video"] as? Bool) ?? false
        voteAverage = (data["vote_average"] as? Double) ?? 0
    }
    
}
