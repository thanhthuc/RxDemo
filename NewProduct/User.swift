//
//  User.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 27/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

class User: NSObject {
   var userName: String!
   var userId: String!
   var userDisplayName: String!
   
   init(dict: [String: AnyObject]) {
      self.userName = dict["username"] as! String
      self.userId = dict["userId"] as! String
      self.userDisplayName = dict["userDisplayName"] as! String
   }
}
