//
//  DashboardVC.swift
//  test
//
//  Created by Kimate Richards on 3/14/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collection.delegate = self
        collection.dataSource = self
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("LocationCell", forIndexPath: indexPath) as? LocationCell{
            
            let location = SWLocation(locationName: "BOB", address1: "BOB", address2: "BOB", address3: "BOB", city: "BOB", state: "BOB", postalCode: "BOB", locationID: 1, googleMapsSmall: "BOB", googleMapsMedium: "BOB", hoursStart: "BOB", hoursEnd: "BOB", daysOpen: "BOB", imageURL:"http://photos.wikimapia.org/p/00/02/59/10/52_big.jpg")
            cell.configureLocationCell(location)
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 420, height: 110)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        collection.reloadData()
    }
}
