//
//  MovieDetailsViewController.swift
//  IPopMovies
//
//  Created by Marcio on 02/02/2018.
//  Copyright © 2018 Marcio. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var yearMovie: UILabel!
    @IBOutlet weak var ratingMovie: UILabel!
    @IBOutlet weak var posterMovie: UIImageView!
    @IBOutlet weak var descriptionMovie: UILabel!
    
    var movie: Movie!
    var imgPoster : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        feedMovieFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func feedMovieFields(){
        self.title = movie.title
        self.titleMovie.text = movie.originalTitle
        self.yearMovie.text = movie.releaseDate
        self.ratingMovie.text = String(movie.voteAverage)
        self.descriptionMovie.text = movie.overview
        self.posterMovie.image = self.imgPoster
    }
    
}
