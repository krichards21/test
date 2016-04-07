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


    var location: SWLocation!
    @IBOutlet weak var hoursLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var address1Lbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.blackColor().CGColor
    }
    func configureLocationCell(location: SWLocation)
    {
        self.location = location

        if self.location.imageURL != nil{
            if let imageUrl = NSURL(string: self.location.imageURL!){
                if let data = NSData(contentsOfURL: imageUrl){
                    thumbnailImg.image = UIImage(data: data)
                }
            }
            if  self.location.locationName != nil{
                nameLbl.text = location.locationName
            }
            if  self.location.address1 != nil{
                address1Lbl.text = location.address1
                //print(self.location.address1 )
            }
            if self.location.city != nil{
                cityLbl.text = location.city
            }
            if self.location.hoursStart != nil{
                hoursLbl.text = location.hoursStart! + "-" + location.hoursEnd!
            }
        }
        //print(location.locationID)
    }
}
