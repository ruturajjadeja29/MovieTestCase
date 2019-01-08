//
//  MovieDetailHeaderTblCell.swift
//  Movie
//
//  Created by mac-0008 on 05/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailHeaderTblCell: UITableViewCell {

    // MARK: -
    // MARK: - @IBOutlets.
    @IBOutlet weak var imgBackMoviePoster: UIImageView!
    @IBOutlet weak var imgMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieTagline: UILabel!
    
    // MARK: -
    // MARK: - Override Methods.
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

// MARK: -
// MARK: - General Methods.
extension MovieDetailHeaderTblCell {
    
    func configureCell() {
        
//        if let tblMovieDetail = TBLMovieDetail.allObjects?.last as? TBLMovieDetail {
//            
//            if let backdropPath = tblMovieDetail.backdrop_path?.toURL {
//                imgBackMoviePoster.kf.setImage(with: backdropPath)
//            }
//            
//            if let posterPath = tblMovieDetail.poster_path?.toURL {
//                imgMoviePoster.kf.setImage(with: posterPath)
//            }
//            
//            lblMovieTitle.text = tblMovieDetail.title
//            lblMovieTagline.text = tblMovieDetail.tagline
//        }
    }
}
