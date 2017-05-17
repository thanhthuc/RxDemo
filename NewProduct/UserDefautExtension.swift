//
//  UserDefautExtension.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 5/1/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

extension UserDefaults {
   
   func setUserForUserDefault(user: User) {
      setUser(user: user, forKey: Constant.kUser)
   }
   
   func userFromUserDefault() -> User? {
      return userFromKey(key: Constant.kUser)
   }
   
   func removeUserFromUserDefault() {
      removeUser(forKey: Constant.kUser)
   }
   
   
   private func setUser(user: User, forKey key: String) {
      UserDefaults.standard.set(user, forKey: key)
      UserDefaults.standard.synchronize()
   }
   
   private func userFromKey(key: String) -> User? {
      let user = UserDefaults.standard.value(forKey: key)
      if let user = user {
         return user as? User
      }
      return nil
   }
   
   private func removeUser(forKey key: String) {
      UserDefaults.standard.removeObject(forKey: key)
      UserDefaults.standard.synchronize()
   }
   
}
