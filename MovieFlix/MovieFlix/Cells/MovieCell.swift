//
//  MovieCell.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var gradientBackgroundImageView: UIView!
    
    //MARK: - Variables
    static let identifier = "MovieCell"
    
    //MARK: - Cell Functions
    override func awakeFromNib() {
        super.awakeFromNib()

        movieImageView.layer.cornerRadius = 10
        movieImageView.layer.masksToBounds = true
        titleLabel.textColor = GlobalConstants.Colors.teal
        genreLabel.textColor = GlobalConstants.Colors.teal
    }
    
    func setPosterImage(with url: String) {
        
        movieImageView.loadImageUsingCache(with: "\(GlobalConstants.API.imageUrl)\(GlobalConstants.URL_Keys.w300_image)\(url)")
    }
}
