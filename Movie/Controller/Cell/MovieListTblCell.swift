//
//  MovieListTblCell.swift
//  Movie
//
//  Created by mac-0009 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit
import Kingfisher

let imgBaseURL = "https://image.tmdb.org/t/p/w500"

class MovieListTblCell: UITableViewCell {

    // MARK: -
    // MARK: - @IBOutlets.
    
    @IBOutlet fileprivate weak var imgVMovie: UIImageView!
    @IBOutlet fileprivate weak var lblMovieTitle: GenericLabel!
    @IBOutlet fileprivate weak var lblMovieReleaseDate: GenericLabel!
    @IBOutlet fileprivate weak var lblMovieOverview: GenericLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}



extension MovieListTblCell {
    
    func configureCell(movie: Movie) {
        
        if let imgVPoster = movie.posterPath {
            imgVMovie.kf.setImage(with: (imgBaseURL + imgVPoster).toURL)
        }
        
        if let strMovieTitle = movie.originalTitle {
            lblMovieTitle.text = strMovieTitle
        }
        
        if let strMovieReleaseDate = movie.releaseDate {
            lblMovieReleaseDate.text = strMovieReleaseDate
        }
        
        if let strMovieOverview = movie.overview {
            lblMovieOverview.text = strMovieOverview
        }
        
    }
    
}
