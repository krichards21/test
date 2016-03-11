//
//  CWProduct.swift
//  test
//
//  Created by Kimate Richards on 3/11/16.
//  Copyright © 2016 designmind. All rights reserved.
//

import Foundation
class SWProduct {
    private var _productID: Int!
    private var _productName: String!
    private var _productDescription: String!
    
    var productID: Int{
        get {
            return _productID
        }
    }
    
    var productName: String{
        get {
            return _productName
        }
    }
    
    var productDescription: String{
        get {
            return _productDescription
        }
    }
    
    init(productID: Int, productName: String, productDescription: String){
        self._productID = productID
        self._productName = productName
        self._productDescription = productDescription
    }
}
