//
//  ServerAPIProvider.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 26/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

protocol RequestType {
   
   var baseURL: String { get }
   
   var path: String { get }
   
   var method: HTTPMethod { get }
   
   var parameters: [String: Any]? { get }
   
   var headers: [String: String]? { get }
}

enum API {
   case products()
   case productDetail(Int)
   case login(String, String)
   case signup(String, String, String)
   case checkout(String, String, String, Float, Int, Int, Int)
}

extension API: RequestType {
   
   var baseURL: String {
      return "http://localhost:3000/api/"
   }
   
   var headers: [String : String]? {
      return ["Content-Type":"application/json", "Accept":"application/json"]
   }
   
   var method: HTTPMethod {
      
      switch self {
      case .products():
         return .GET
      default:
         return .POST
      }
   }
   
   var parameters: [String : Any]? {
      switch self {
         
      case let .productDetail(productId):
         return ["productId": productId]
         
      case let .login(username, password):
         return ["username": username, "password": password]
         
      case let .signup(username, password, repeatedPassword):
         return ["username": username,
                 "password": password,
                 "repeatedPassword": repeatedPassword]
         
      case let .checkout(receiptName, datetime, products, totalPrice, method, currencyUnit, userId):
         return ["receiptName": receiptName,
                 "datetime": datetime,
                 "products": products,
                 "totalPrice": totalPrice,
                 "method": method,
                 "currencyUnit": currencyUnit,
                 "userId": userId]
         
      default:
         return nil
      }
   }
   
   var path: String {
      
      switch self {
         
      case .products:
         return "listProduct"
         
      case .productDetail:
         return "productDetail"
         
      case .login:
         return "login"
         
      case .signup:
         return "register"
         
      case .checkout:
         return "checkout"
      }
   }
}











