//
//  MovieDetailTblCell.swift
//  Movie
//
//  Created by mac-0008 on 05/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit

class MovieDetailTblCell: UITableViewCell {
    
    // MARK: -
    // MARK: - @IBOutlets.
    @IBOutlet  weak var lblTitle: UILabel!
    @IBOutlet  weak var lblSubTitle: UILabel!
    
    // MARK: -
    // MARK: - Override Methods.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MovieDetailTblCell {
    
    func configureCell(movieDetails:MovieDetailModel) {
        
        if let strTitle = movieDetails.title {
            lblTitle.text = strTitle
        }
        
        if let content = movieDetails.contents as? String {
            lblSubTitle.text = content
        }
    }
}
