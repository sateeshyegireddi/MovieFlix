//
//  LabelCell.swift
//  MovieFlix
//
//  Created by Sateesh on 8/8/18.
//  Copyright © 2018 Company. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Variables
    static let identifier = "LabelCell"

    //MARK: - Cell Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.clear

        titleLabel.textColor = UIColor.white
    }
}
