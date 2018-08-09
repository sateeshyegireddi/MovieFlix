//
//  MovieDetailsCell.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

class MovieDetailsCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    //MARK: - Variables
    static let identifier = "MovieDetailsCell"
    
    //MARK: - Cell Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear
        
        titleLabel.textColor = UIColor.white
        genreLabel.textColor = UIColor.white
        budgetLabel.textColor = UIColor.white
        popularityLabel.textColor = UIColor.white
        releaseDateLabel.textColor = UIColor.white
    }
}
