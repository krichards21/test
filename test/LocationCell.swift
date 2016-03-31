//
//  LocationCell.swift
//  test
//
//  Created by Kimate Richards on 3/14/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import UIKit

class LocationCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImg: UIImageView!
//    @IBOutlet weak var locationNameLbl: UILabel!
//    @IBOutlet weak var distanceLbl: UILabel!
//    @IBOutlet weak var statusLbl: UILabel!
//    @IBOutlet weak var lastVisitDate: UILabel!
//    @IBOutlet weak var locationBtn: UIButton!
//    @IBOutlet weak var directionsBtn: UIButton!
    
    var location: SWLocation!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    func configureLocationCell(location: SWLocation)
    {
        self.location = location
        //print(location.imageURL)
        //print(self.location.locationID)
        //locationNameLbl.text = self.location.locationName
        if self.location.imageURL != nil{
            if let imageUrl = NSURL(string: self.location.imageURL){
                if let data = NSData(contentsOfURL: imageUrl){
                    thumbnailImg.image = UIImage(data: data)
                }
            }
        }
        //print(location.locationID)
    }
}
