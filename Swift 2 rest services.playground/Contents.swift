//: Playground - noun: a place where people can play

import UIKit

let postEndpoint: String = "http://localhost:3830/location/getlocation/1"
let url = NSURL(string: postEndpoint)

let urlRequest = NSURLRequest(URL: url!)

let config = NSURLSessionConfiguration


