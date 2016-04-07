//
//  Functions.swift
//  test
//
//  Created by Kimate Richards on 4/7/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import Foundation

func getDateFunction(dateString:NSString) -> NSDate{
    
    
    var dateFormatter = NSDateFormatter()
    
    if(dateString.length == 19)
    {
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss" //This is the format returned by .Net website
    }
    else if(dateString.length == 21)
    {
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.S" //This is the format returned by .Net website
    }
    else if(dateString.length == 22)
    {
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SS" //This is the format returned by .Net website
    }
    else if(dateString.length == 23)
    {
        dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS"
    }
    
    
    return dateFormatter.dateFromString(dateString as String)!;
    
}

