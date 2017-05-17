//
//  Receipt.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 17/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

class Receipt {
   var receiptName: String
   var dateTime: String
   var product: String
   var priceTotal: Float
   var method: Int
   var currentUnit:Int
   var userId: Int
   
   init(receiptName: String, priceTotal: Float, userId: Int) {
      
      let date = "2016-04-04 00:00:00"
      self.dateTime = date
      self.receiptName = receiptName
      
      self.product = Receipt.generateJSONStringProducts(dict:
                     ShoppingCart.sharedCart.dict.value)
      self.priceTotal = priceTotal
      self.method = 1
      self.currentUnit = 1
      self.userId = userId
   }
   
   
   class func generateJSONStringProducts(dict:[Int: Int]) -> String {
      let dict = dict
      var count = dict.count
      var result = "["
      dict.forEach { item in
         let key = item.key
         let value = item.value
         
         //value is number of item with each productId
         result += "{ \(key) : { productId : \(key), count : \(value) } }"
         count -= 1
         if count>0  {
            result += ","
         }
      }
      result += "]"
      return result
   }
}
