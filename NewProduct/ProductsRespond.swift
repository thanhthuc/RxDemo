//
//  ProductsRespond.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 27/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

class ProductsRespond {
   var statusCode: Int!
   var message: String!
   var products: [Product]!
   
   init(dict: Dictionary<String, AnyObject>) {
      guard let statusCode = dict["statusCode"],
            let message = dict["message"],
            let productsDict = dict["products"] else {
         return
      }
      
      self.statusCode = statusCode as! Int
      self.message = message as! String
      
      let tempProductsDict = productsDict as! [[String: AnyObject]]
      
      self.products = []
      tempProductsDict.forEach { dict in
         let dict = dict
         let product = Product(dict: dict)
         self.products.append(product)
      }
   }
}
