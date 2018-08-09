//
//  MovieDetails.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

class MovieDetails: NSObject
{
    var id: Int
    var title: String
    var imageUrl: String
    var genres: [Genre]
    var overview: String
    var releaseDate: String
    var popularity: Double
    var budget: Int
    
    override init() {
        
        id = 0
        title = ""
        imageUrl = ""
        genres = []
        overview = ""
        releaseDate = ""
        popularity = 0.0
        budget = 0
    }
    
    init(dict: [String: Any]?) {
        
        id = Functions().parseInt(in: dict, for: "id")
        
        title = dict?["original_title"] as? String ?? ""
        
        imageUrl = dict?["backdrop_path"] as? String ?? ""

        genres = []
        
        if let genresArray = dict?["genres"] as? [[String: Any]] {
            for genre in genresArray {
                genres.append(Genre(dict: genre))
            }
        }
        
        overview = dict?["overview"] as? String ?? ""

        releaseDate = dict?["release_date"] as? String ?? ""
        
        popularity = Functions().parseDouble(in: dict, for: "popularity")
        
        budget = Functions().parseInt(in: dict, for: "budget")
    }
}
