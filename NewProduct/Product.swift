//
//  Product.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 3/12/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit


/// Returns a Boolean value indicating whether two values are equal.
///
/// Equality is the inverse of inequality. For any values `a` and `b`,
/// `a == b` implies that `a != b` is `false`.
///
/// - Parameters:
///   - lhs: A value to compare.
///   - rhs: Another value to compare.

//1: ten SP
//2: so luogn
//3: gia thanh
//4: tong tien

//check out: true/false ==>
//layout item and cost


class Product: Equatable, Hashable {
   /// The hash value.
   ///
   /// Hash values are not guaranteed to be equal across different executions of
   /// your program. Do not save hash values to use during a future execution.
   
   public static func ==(lhs: Product, rhs: Product) -> Bool {
      
      let isEqual = lhs.productId == rhs.productId &&
         lhs.productName == rhs.productName
      return isEqual
   }
   
   
   public var hashValue: Int {
      return productImageUrl.hashValue
   }
   
   var productId: Int
   var productName: String
   var addressName: String
   var productImageUrl: String
   var productPrice: String?
   
   var districtName: String?
   var latitude: Double?
   var longitude: Double?
   var rating: String?
   var restaurantName: String?
   var urlrelate: String?
   
   
   
   init(dict: [String: AnyObject], isForDetail: Bool = false) {
      
      guard let productId = dict["productId"],
         let productName = dict["productName"],
         let addressName = dict["addressName"],
         let productImageUrl = dict["productImageUrl"] else {
            fatalError("error for dictionary")
      }
      self.productId = productId as! Int
      self.productName = productName as! String
      self.addressName = addressName as! String
      self.productImageUrl = productImageUrl as! String
      
      if isForDetail {
         //If this field not null
         if
            let districtName = dict["districtName"],
            let latitude = dict["latitude"],
            let longitude = dict["longitude"],
            let rating = dict["rating"],
            let restaurantName = dict["restaurantName"],
            let urlrelate = dict["urlrelate"]
         {
            self.districtName = districtName as? String
            self.latitude = latitude as? Double
            self.longitude = longitude as? Double
            self.rating = rating as? String
            self.restaurantName = restaurantName as? String
            self.urlrelate = urlrelate as? String
            let productPrice = dict["productPrice"]
            self.productPrice = String(describing: productPrice)
         }
         
      } else {
         
         if
            let productPrice = dict["productPrice"]
         {
            self.productPrice = String(describing: productPrice)
         }
      }
   }
   
}
