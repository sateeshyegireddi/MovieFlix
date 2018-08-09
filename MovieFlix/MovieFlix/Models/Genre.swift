//
//  Genre.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

class Genre: NSObject
{
    var id: Int
    var name: String
    
    override init() {
        
        id = 0
        name = ""
    }
    
    init(dict: [String: Any]?) {
        
        id = Functions().parseInt(in: dict, for: "id")
        name = dict?["name"] as? String ?? ""
    }
}
