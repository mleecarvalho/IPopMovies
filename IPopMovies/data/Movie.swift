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
        posterPath = (data["posterPath"] as? String) ?? ""
        adult = (data["adult"] as? Bool) ?? false
        overview = (data["overview"] as? String) ?? ""
        releaseDate = (data["releaseDate"] as? String) ?? ""
        id = (data["id"] as? Int) ?? 0
        originalTitle = (data["originalTitle"] as? String) ?? ""
        originalLanguage = (data["originalLanguage"] as? String) ?? ""
        title = (data["title"] as? String) ?? ""
        backdropPath = (data["backdropPath"] as? String) ?? ""
        popularity = (data["popularity"] as? Double) ?? 0
        voteCount = (data["voteCount"] as? Int) ?? 0
        video = (data["video"] as? Bool) ?? false
        voteAverage = (data["voteAverage"] as? Double) ?? 0
    }
    
}
