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
    
    func requestMovies(type: MovieOrderBy) -> [Movie] {
        return getResponseFromHttpUrl(url: buildRequestUrl(path: getRequestPath(type: type)))
    }
    
    func getMovieImage(imageView: UIImageView, imagePath: String) {
        getDataFromUrl(url: buildRequestUrl(path: imagePath)) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    private func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    private func getPicassoURLImage(picture: String) -> String {
        var urlImage = picture
        if(!urlImage.isEmpty){
            urlImage.append(picassoEndpoint)
        }
        return urlImage
    }
    
    private func getRequestPath(type: MovieOrderBy) -> String {
        switch(type) {
            case MovieOrderBy.POPULARITY: return popularityPath
            case MovieOrderBy.RATING: return topRatedPath
            default: return popularityPath
        }
    }
    
    private func buildRequestUrl(path: String) -> URL {
        var components = URLComponents(string: path)!
        components.queryItems = [URLQueryItem(name:"api_key", value:apiDBKey)]
        return components.url!
    }
    
    private func requestMoviesList(movieUrl: URL) -> [Movie] {
            return  getResponseFromHttpUrl(url: movieUrl)
    }
    
    
    private func getResponseFromHttpUrl(url: URL) -> [Movie] {
        var results = [Movie]()
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data, request, error) in
            if error == nil {
                if let returnData = data {
                    do{
                        if let jsonObject = try JSONSerialization.jsonObject(with: returnData, options: []) as? [String: Any] {
                            print("Request List", jsonObject)
                            results = jsonObject["results"] as! [Movie]
                        }
                    }catch{
                        print("Erro ao formatar o retorno.")
                    }
                }
            }else{
                print("Erro ao fazer a consulta do preço.")
            }
        }
        task.resume()
        
        return results
 
    }


}
