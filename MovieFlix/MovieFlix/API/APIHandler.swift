//
//  APIHandler.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

enum HTTPMethod {
    case get
    case post
}

class APIHandler: NSObject
{
    private func sendRequest(to url: String, withData parameters: [String: Any]?, httpMethod method: HTTPMethod, completionHandler: @escaping (_ success: Bool, _ response: [String: Any]?, _ error: String?) ->()) {
        
        //Create url request with speicific given url
        var request = URLRequest(url: URL(string: "\(GlobalConstants.API.baseUrl)\(url)")!)

        //Check which http method this API call are using
        switch method {
        case .get:
            
            //Get method
            request.httpMethod = "GET"

        default:
            
            //Post method
            request.httpMethod = "POST"
            
            //Set body to url request
            if parameters != nil {
                
                do {
                    let bodyData = try JSONSerialization.data(withJSONObject: parameters!,
                                                              options: JSONSerialization.WritingOptions.prettyPrinted)
                    request.httpBody = bodyData
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        
        //Create URL Session Configuration Object
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        //Fetch the contents of url from API Server
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            //Return error message if the API didn't response or not data from it
            guard data != nil && error == nil else {
                completionHandler(false, nil, "Something went wrong. Please try again")
                return
            }
            
            //Extract response from the data
            var responseDict = [String: Any]()
            let responseString = String.init(data: data!, encoding: String.Encoding.utf8)!
            
            if let responsedata = responseString.data(using: String.Encoding.utf8) {
                
                do {
                    responseDict = try JSONSerialization.jsonObject(with: responsedata, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any]
                    print("JSON RESPONSE: ---> \(String(describing: responseString.replacingOccurrences(of: "\\", with: "")))")
                    print("responseDict \(responseDict)")
                    completionHandler(true, responseDict, nil)

                } catch let error {

                    completionHandler(false, nil, error.localizedDescription)
                }
            }
        }
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
    func getGenres(with parameters: [String: Any]?, completionHandler: @escaping(_ success: Bool, _ genres: [Genre]?, _ error: String?) -> ()) {
        
        //https://api.themoviedb.org/3/genre/movie/list?api_key=109d15f060cc55a763ab8fd9eebd82bd&language=en-US
        let url = GlobalConstants.API.genres + GlobalConstants.URL_Keys.api_key +
            GlobalConstants.Constants.api_key + GlobalConstants.URL_Keys.language
        
        sendRequest(to: url, withData: nil, httpMethod: .get) { (success, response, error) in
            
            //On success
            if success {
                
                //Create genres array
                var genres = [Genre]()
                
                //Check if response is nil
                if response != nil {
                    
                    //Extract genres from response
                    if let genresArray = response!["genres"] as? [[String: Any]] {
                        
                        //Looping over genres
                        for genreObject in genresArray {
                            
                            genres.append(Genre(dict: genreObject))
                        }
                    }
                }
                
                completionHandler(true, genres, nil)
            } else {
                
                completionHandler(false, nil, error)
            }
        }
    }
    
    func getMovies(with parameters: [String: Any]?, pageNumber number: Int, genres genresArray: [Genre], completionHandler: @escaping(_ success: Bool, _ movies: [Movie]?, _ error: String?) -> ()) {
        
        //https://api.themoviedb.org/3/movie/popular?api_key=109d15f060cc55a763ab8fd9eebd82bd&language=en-US&page=1
        let url = GlobalConstants.API.popular_movie + GlobalConstants.URL_Keys.api_key +
            GlobalConstants.Constants.api_key + GlobalConstants.URL_Keys.language + GlobalConstants.URL_Keys.page + "\(number)"
        
        sendRequest(to: url, withData: nil, httpMethod: .get) { (success, response, error) in
            
            //On success
            if success {
                
                //Create movies array
                var movies = [Movie]()
                
                //Check if response is nil
                if response != nil {
                    
                    //Extract movies from response
                    if let moviesArray = response!["results"] as? [[String: Any]] {
                        
                        //Looping over genres
                        for movieObject in moviesArray {
                            
                            movies.append(Movie(dict: movieObject, genresArray: genresArray))
                        }
                    }
                }
                
                completionHandler(true, movies, nil)
            } else {
                
                completionHandler(false, nil, error)
            }
        }
    }
    
    func getMovieDetails(for id: Int, completionHandler: @escaping(_ success: Bool, _ movieDetails: MovieDetails?, _ error: String?) -> ()) {
        
        //https://api.themoviedb.org/3/movie/299536?api_key=109d15f060cc55a763ab8fd9eebd82bd&language=en-US
        let url = GlobalConstants.API.movie + "\(id)?" + GlobalConstants.URL_Keys.api_key +
            GlobalConstants.Constants.api_key + GlobalConstants.URL_Keys.language
        
        sendRequest(to: url, withData: nil, httpMethod: .get) { (success, response, error) in
            
            //On success
            if success {
                
                //Create movieDetails object
                var movieDetails = MovieDetails()
                
                //Check if response is nil
                if response != nil {
                    
                    movieDetails = MovieDetails(dict: response)
                }
                
                completionHandler(true, movieDetails, nil)
            } else {
                
                completionHandler(false, nil, error)
            }
        }
    }
}
