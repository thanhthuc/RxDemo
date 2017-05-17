//
//  APIRequest.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 26/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

class APIRequest: NSObject {
   
   static let sharedAPI = APIRequest()
   
   func login(username: String, password: String) -> Observable<LoginRespond> {
      return APIProvider<API>.init(requestType: .login(username, password)).APIrequest()
   }
   
   func signup(username: String) -> Observable<SignupRespond> {
      
      //this method just check exist username
      return APIProvider<API>.init(requestType: .signup(username, "", "")).APIrequest()
   }
   
   func products() -> Observable<ProductsRespond> {
      return APIProvider<API>.init(requestType: .products()).APIrequest()
   }
   
   func productDetail(productId: Int) -> Observable<Product> {
      return APIProvider<API>.init(requestType: .productDetail(productId)).APIrequest()
   }
   
   func checkout(receipt: Receipt) -> Observable<CheckoutRespond> {
      return APIProvider<API>.init(requestType: .checkout(receipt.receiptName,
                                                          receipt.dateTime,
                                                          receipt.product, receipt.priceTotal,
                                                          receipt.currentUnit,
                                                          receipt.method, receipt.userId)).APIrequest()
   }
}
