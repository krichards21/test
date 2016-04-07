//
//  HomeController.swift
//  test
//
//  Created by Kimate Richards on 4/5/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collection: UICollectionView!
    let managedObjectContext = DataController().managedObjectContext
    let url = "\(URL_BASE)\(URL_LOCATION_CONTROLLER)"
    var fetchedNews = [NewsEntity]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        collection.delegate = self
        collection.dataSource = self
        }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NewsFeedCell", forIndexPath: indexPath) as? NewsFeedCell{
            
            cell.configureNewsFeedCell(fetchedNews[indexPath.row])
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 300, height: 120)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    }
    
    func deleteAllData()
    {
        let newsFetch = NSFetchRequest(entityName: "NewsEntity")
        do{
            let entity = try managedObjectContext.executeFetchRequest(newsFetch) as! [NewsEntity]
            for location in entity{
                managedObjectContext.deleteObject(location)
            }
            try managedObjectContext.save()
        }catch{
            print(error)
        }
    }
    
    func downloadNews(completionHandler:(Bool) -> ()){
        let locationURL = NSURL(string: "\(URL_BASE)news/getnews/")!
        let parameters = [
            "ServiceProvider": SERVICE_PROVIDER
        ]
        Alamofire.request(.GET, locationURL, parameters: parameters).responseJSON {
            response in
            let result = response.result
            if result.isSuccess
            {
                let json = JSON(response.result.value!)
                for jsonArrayNode in json.array!
                {
                    let locationName = jsonArrayNode["LocationName"].stringValue
                    let locationID = jsonArrayNode["LocationID"].intValue
                    let imageURL = jsonArrayNode["ImageURL"].stringValue
                    let address1 = jsonArrayNode["Address1"].stringValue
                    let address2 = jsonArrayNode["Address2"].stringValue
                    let address3 = jsonArrayNode["Address3"].stringValue
                    let city = jsonArrayNode["City"].stringValue
                    let state = jsonArrayNode["State"].stringValue
                    let postalCode = jsonArrayNode["PostalCode"].stringValue
                    let hoursStart = jsonArrayNode["HourStart"].stringValue
                    let hoursEnd = jsonArrayNode["HourEnd"].stringValue
                    
                    
                    
                    do {
                        let entity = NSEntityDescription.insertNewObjectForEntityForName("NewsEntity", inManagedObjectContext: self.managedObjectContext) as! NewsEntity
                        
                        entity.setValue(locationID, forKey: "locationID")
                        entity.setValue(locationName, forKey: "locationName")
                        entity.setValue(imageURL, forKey: "imageURL")
                        entity.setValue(address1, forKey: "address1")
                        entity.setValue(address2, forKey: "address2")
                        entity.setValue(address3, forKey: "address3")
                        entity.setValue(city, forKey: "city")
                        entity.setValue(state, forKey: "state")
                        entity.setValue(postalCode, forKey: "postalCode")
                        entity.setValue(hoursStart, forKey: "hoursStart")
                        entity.setValue(hoursEnd, forKey: "hoursEnd")
                        
                        try self.managedObjectContext.save()
                        
                    } catch {
                        fatalError("Failure to save context: \(error)")
                    }
                }
                completionHandler(true)
            }
            else{
                completionHandler(false)
            }
            
        }
    }
}
