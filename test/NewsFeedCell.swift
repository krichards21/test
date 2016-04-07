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
    @IBOutlet weak var newsFeedDate: UILabel!
    @IBOutlet weak var newsFeedAlertImage: UIImageView!
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.blackColor().CGColor
    }
    
    func configureNewsFeedCell(news: NewsEntity){
        if news.alertType == true
        {
            newsFeedAlertImage.image = UIImage(named:"1460070719_caution.png")
        }
        else{
            newsFeedAlertImage.image = UIImage(named:"1460070737_news.png")
        }
        newsFeedDate.text = news.dateNews?.description
        newsFeedDescription.text = news.alertDescription
    }
}
