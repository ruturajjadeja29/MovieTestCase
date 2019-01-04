//
//  GenericButton.swift
//  Movie
//
//  Created by mac-0009 on 04/01/19.
//  Copyright © 2019 mac-0009. All rights reserved.
//

import UIKit

class GenericButton: UIButton {
    
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
        self.titleLabel?.font = UIFont(name: (self.titleLabel?.font.fontName)!, size: round(CScreenWidth * ((self.titleLabel?.font.pointSize)! / 375)))
    }
}
