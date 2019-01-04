//
//  GenericLabel.swift
//  Movie
//
//  Created by mac-0009 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit

class GenericLabel: UILabel {
    
    //MARK:-
    //MARK:- Override
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    convenience override init(frame: CGRect) {
        self.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK:-
    //MARK:- Initialize
    fileprivate func initialize() {
        self.font = UIFont(name: self.font.fontName, size: round(CScreenWidth * (self.font.pointSize / 375)))
    }
}
