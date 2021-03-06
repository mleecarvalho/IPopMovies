//
//  apiConnection.swift
//  IPopMovies
//
//  Created by Marcio on 30/01/2018.
//  Copyright © 2018 Marcio. All rights reserved.
//

import Foundation
import UIKit

class ApiConnection{

    private let apiDBKey: String = "3502fee1eb0ff1815d316905b20662eb"
    private let movieDBEndpoint: String = "https://api.themoviedb.org/"
    private let picassoEndpoint: String = "http://image.tmdb.org/t/p/w185"
    private let popularityPath: String = "3/movie/popular"
    private let topRatedPath: String = "3/movie/top_rated"
    
    func requestMovies(type: MovieOrderBy, listener: ResponseListener) {
        getResponseFromHttpUrl(url: self.buildRequestUrl(url: movieDBEndpoint, path: self.getRequestPath(type: type)), listener: listener)
    }
    
    func getMovieImage(imageView: UIImageView, imagePath: String, waitloadingView : UIActivityIndicatorView) {
        let imgURL  = URL(string: picassoEndpoint+imagePath)!
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: imgURL) { (data, response, error) -> Void in
            if let e = error {
                print("Error downloading movie picture: \(e)")
            } else { 
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data!)
                    waitloadingView.stopAnimating()
                }
            }

        }.resume()
    }
    
    private func getRequestPath(type: MovieOrderBy) -> String {
        switch(type) {
            case MovieOrderBy.POPULARITY: return popularityPath
            case MovieOrderBy.RATING: return topRatedPath
        }
    }
    
    private func buildRequestUrl(url: String, path: String) -> URL {
        var components = URLComponents(string: url+path)!
        components.queryItems = [URLQueryItem(name:"api_key", value:apiDBKey)]
        return components.url!
    }
    
    private func getResponseFromHttpUrl(url: URL, listener: ResponseListener) {
      
        let operationsQueue = OperationQueue()
        
        // semaphore with count equal to zero is useful for synchronizing completion of work, in our case the renewal of auth token
        let sema = DispatchSemaphore.init(value: 1);
        operationsQueue.addOperation({
            print("Operation 1 - start")
            let task = URLSession.shared.dataTask(with: url) { (data, request, error) in
                if let e = error {
                    print("Error return data from server : \(e)")

                }else {
                    if let returnData = data {
                        do{

                            if let jsonObject = try JSONSerialization.jsonObject(with: returnData, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [String:AnyObject] {
                                print("Request List", jsonObject)
                                let arrayReturn: Array<[String: Any]> = jsonObject["results"] as! Array<[String: Any]>

                                listener.updateMovies(movies: self.processResponse(results: arrayReturn))
                            }
                        }catch{
                            print("Error to format data")
                        }
                    }
                    
                }
                // Signal that we are done
                sema.signal()
            }
            task.resume()

            // Now we wait until the response block will send send a signal
            sema.wait()

            print("Operation 1 - end")
        })
        
 
    }
    
    private func processResponse(results: Array<[String: Any]> ) -> [Movie]{
        var movies: [Movie] = []
        if  results.count > 0 {
            for row in results {
                movies.append(Movie(data: row))
            }
        }
        return movies
    }

}
