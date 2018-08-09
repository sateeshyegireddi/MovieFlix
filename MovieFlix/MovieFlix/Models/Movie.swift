//
//  Movie.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

class Movie: NSObject
{
    var id: Int
    var title: String
    var imageUrl: String
    var genres: [Genre]
    
    override init() {
        
        id = 0
        title = ""
        imageUrl = ""
        genres = []
    }
    
    init(dict: [String: Any]?, genresArray: [Genre]) {
        
        id = Functions().parseInt(in: dict, for: "id")
        
        title = dict?["title"] as? String ?? ""
        
        imageUrl = dict?["poster_path"] as? String ?? ""
        
        genres = []
        
        if let genresIds = dict?["genre_ids"] as? [Int] {
            for genreId in genresIds {
                let genre = genresArray.filter { $0.id == genreId }
                genres.append(genre[0])
            }
        }
    }
}
