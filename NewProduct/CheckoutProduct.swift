//
//  CheckoutProduct.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 14/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

class CheckoutProduct: NSObject {
   
   static let sharedCheckoutAPI = CheckoutProduct()
   
   func checkoutProducts(forReceipt receipt: Receipt) -> Observable<Bool> {
     
     return APIRequest.sharedAPI.checkout(receipt: receipt)
      .map({ (checkoutRespond) -> Bool in
         print(checkoutRespond.statusCode)
      return (checkoutRespond.statusCode == 1)
     })
   }
}
