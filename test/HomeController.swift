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
import SwiftKeychainWrapper

class HomeController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collection: UICollectionView!

    let managedObjectContext = DataController().managedObjectContext
    
    let url = "\(URL_BASE)\(URL_ALERTS_CONTROLLER)"
    var fetchedNews = [NewsEntity]()
    var userID: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.deleteAllData()
        
        downloadNews(){ completion in
            if completion {
                self.loadNews()
            }
        }
        collection.layer.cornerRadius = 5
        
        collection.delegate = self
        collection.dataSource = self
        }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NewsFeedCell", forIndexPath: indexPath) as? NewsFeedCell{
            
            var news: NewsEntity!
                news = fetchedNews.reverse()[indexPath.row]
            
            cell.configureNewsFeedCell(news)
            
            return cell
        }else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let news: NewsEntity!
//        if inSearchmode{
//            location = filteredLocations[indexPath.row]
//        }else{
//            location = self.fetchedLocation[indexPath.row]
//        }
        //performSegueWithIdentifier("LocationDetailVC", sender: location)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedNews.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
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
            for news in entity{
                managedObjectContext.deleteObject(news)
            }
            try managedObjectContext.save()
        }catch{
            print(error)
        }
    }
    
    func loadNews(){
        let newsFetch = NSFetchRequest(entityName: "NewsEntity")
        do{
            
            fetchedNews = try managedObjectContext.executeFetchRequest(newsFetch) as! [NewsEntity]
            collection.reloadData()
        }catch{
            fatalError("ooooo \(error)")
        }
    }
    
    func downloadNews(completionHandler:(Bool) -> ()){
        //let locationURL = NSURL(string: "\(URL_BASE)alerts/getalerts/\(userID)")!
        let locationURL = NSURL(string: "\(URL_BASE)alerts/getalerts/1")!
        
        let request = NSMutableURLRequest(URL: locationURL)
        request.HTTPMethod = "GET"
        request.timeoutInterval = 60
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(KeychainWrapper.stringForKey("aspUserID")!, forHTTPHeaderField: "UserID")
        request.addValue(KeychainWrapper.stringForKey("accessToken")!, forHTTPHeaderField: "AccessToken")
        request.addValue("\(SERVICE_PROVIDER)", forHTTPHeaderField: "ServiceProviderID")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request)
        {
            data, response, error in

            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let jsonData = responseString?.dataUsingEncoding(NSUTF8StringEncoding)!
            
            let json = JSON(data: jsonData!)
            for result in json.arrayValue{
                let alertID = result["AlertID"].intValue
                print(alertID)
                
                let description = result["Description"].stringValue
                print(description)
                let alertType  = result["AlertType"].boolValue
                let dateNews = result["CreateDate"].stringValue
                do {
                    let entity = NSEntityDescription.insertNewObjectForEntityForName("NewsEntity", inManagedObjectContext: self.managedObjectContext) as! NewsEntity
                
                    entity.setValue(alertID, forKey: "alertID")
                    entity.setValue(description, forKey: "alertDescription")
                    entity.setValue(alertType, forKey: "alertType")
                    entity.setValue(getDateFunction(dateNews), forKey: "dateNews")
                    try self.managedObjectContext.save()
                
                } catch {
                fatalError("Failure to save context: \(error)")
                }
            }
//            do {
//                let obj = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
//                if let dict = obj as? [String: AnyObject]{
//                    if let alertID = dict["AlertID"] as? String{
//                        print(alertID)
//                    }
//                }
//            }
//            catch{
//                
//            }
            completionHandler(true)
            //print(responseString)
            //var jsonObjectArray = JSON(responseString!).array!
        }
        task.resume()
//        Alamofire.request(.GET, locationURL, headers: headers).responseJSON {
//            response in
//            let result = response.result
//            if result.isSuccess
//            {
//                let json = JSON(response.result.value!)
//                var error = false;
//                if let message = json["Message"].string{
//                    error = true
//                }
//                if (!error)
//                {
//                    for jsonArrayNode in json.array!
//                    {
//                        let alertDescription = jsonArrayNode["Description"].stringValue
//                        let alertType = jsonArrayNode["AlertType"].boolValue
//                        let dateNews = jsonArrayNode["CreateDate"].stringValue
//                        
//                        
//                        do {
//                            let entity = NSEntityDescription.insertNewObjectForEntityForName("NewsEntity", inManagedObjectContext: self.managedObjectContext) as! NewsEntity
//                            
//                            entity.setValue(alertDescription, forKey: "alertDescription")
//                            entity.setValue(alertType, forKey: "alertType")
//                            entity.setValue(getDateFunction(dateNews), forKey: "dateNews")
//                            try self.managedObjectContext.save()
//                            
//                        } catch {
//                            fatalError("Failure to save context: \(error)")
//                        }
//                    }
//                    completionHandler(true)
//                }
//            }
//            else{
//                completionHandler(false)
//            }
        
        //}
    }
}
