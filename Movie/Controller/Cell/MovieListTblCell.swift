//
//  MovieListTblCell.swift
//  Movie
//
//  Created by mac-0009 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListTblCell: UITableViewCell {

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
    
    func configureCell(movie: TBLMovieList) {
        
//        if let imgVPoster = movieList.moviePoster.URL(string) {
//            imgVMovie.kf.setImage(with: imgVPoster)
//        }
        
        if let strMovieTitle = movie.original_title {
            lblMovieTitle.text = strMovieTitle
        }
        
        if let strMovieReleaseDate = movie.release_date {
            lblMovieReleaseDate.text = strMovieReleaseDate
        }
        
        if let strMovieOverview = movie.overview {
            lblMovieOverview.text = strMovieOverview
        }
        
    }
    
}
