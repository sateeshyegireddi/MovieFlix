//
//  GlobalConstants.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

class GlobalConstants: NSObject {

    struct Constants {
        
        static let appName = "MovieFlix"
        static let api_key = "109d15f060cc55a763ab8fd9eebd82bd"
    }
    
    struct API {
    
        static let baseUrl = "https://api.themoviedb.org/3/"
        static let imageUrl = "http://image.tmdb.org/t/p/"
        static let genres = "genre/movie/list?"
        static let popular_movie = "movie/popular?"
        static let movie = "movie/"
    }
    
    struct URL_Keys {
        
        static let api_key = "api_key="
        static let language = "&language=en-US"
        static let w300_image = "w300"
        static let w500_image = "w500"
        static let origin_image = "original"
        static let page = "&page="
    }
    
    struct Colors {
        
        static let orange = UIColor(red: (240.0/255.0), green: (150.0/255.0), blue: (75.0/255.0), alpha: 1)
        static let teal = UIColor(red: (50.0/255.0), green: (205.0/255.0), blue: (180.0/255.0), alpha: 1)
    }
    
    struct SegueId {
        
        static let movieDetails = "ToMovieDetails"
    }
}
