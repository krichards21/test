//
//  NewsFeedCell.swift
//  test
//
//  Created by Kimate Richards on 4/6/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import UIKit

class NewsFeedCell: UICollectionViewCell {
    
    var news: NewsEntity!

    @IBOutlet weak var newsFeedDescription: UILabel!
    @IBOutlet weak var newfeedDate: UILabel!
    @IBOutlet weak var newsfeedAlertImage: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureNewsFeedCell(news: NewsEntity){
        
    }
}
