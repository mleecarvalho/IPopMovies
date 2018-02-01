//
//  ResponseListener.swift
//  IPopMovies
//
//  Created by Marcio on 31/01/2018.
//  Copyright © 2018 Marcio. All rights reserved.
//

import Foundation

protocol ResponseListener{
    func updateMovies(movies: [Movie])
}
