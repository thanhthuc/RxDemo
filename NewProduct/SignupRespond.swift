//
//  signupRespond.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 27/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

class SignupRespond: NSObject {
   var statusCode: Int!
   var message: String!
   
   init(dict: [String: AnyObject]) {
      guard let statusCode = dict["statusCode"],
            let message = dict["message"] else {
         return
      }
      self.statusCode = statusCode as! Int
      self.message = message as! String
   }
}
