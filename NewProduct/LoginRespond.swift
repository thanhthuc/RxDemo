//
//  LoginRespond.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 27/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

class LoginRespond: NSObject {
   var statusCode: Int!
   var message: String!
   var user: User!
   
   init(dict: [String: AnyObject]) {
      guard let statusCode = dict["statusCode"],
            let message = dict["message"] else {
         return
      }
      self.statusCode = statusCode as! Int
      self.message = message as! String
      
      guard let userDict = dict["user"] as? [String: AnyObject] else {
         return
      }
      self.user = User(dict: userDict)
   }
}
