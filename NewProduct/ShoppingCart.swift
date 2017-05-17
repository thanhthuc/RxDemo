//
//  ShoppingCart.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 10/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

class ShoppingCart {
   
   static let sharedCart = ShoppingCart()
   
   var products: Variable<Set<Product>> = Variable([])
   
   var dict: Variable<[Int: Int]> = Variable([:])
   
   func totalCost() -> Float {
      
      var newArrPrice: [Float] = []
      
      for item in self.products.value {
         
         for (key, value) in self.dict.value {
            
            if item.productId == key {
               let price = Float(item.productPrice!)! * Float(value)
               newArrPrice.append(price)
            }
         }
      }
      let totalCost = newArrPrice
         .reduce(0) {
            (resultRunning, price) -> Float in
         return resultRunning + price
      }
      
      return totalCost
   }
   
   func totalCount() -> Int {
      
      let totalCount = self.dict.value
         .reduce(0) {
            (resultRunning, dict: (key: Int, value: Int)) -> Int in
         return resultRunning + dict.value
      }
      return totalCount
   }
}
