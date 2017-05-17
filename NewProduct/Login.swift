//
//  Login.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 3/15/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import RxSwift

final class LoginDefaultAPI: LoginAPI  {
   
   static let sharedLoginAPI = LoginDefaultAPI()
   
   func usernameAndPassAvailable(username: String, password: String) -> Observable<Bool> {
      
      return APIRequest.sharedAPI
         .login(username: username, password: password)
         .map({ (loginRespond) -> Bool in
         return (loginRespond.statusCode != 2)
      })
   }
   
   func login(username: String, password: String) -> Observable<Bool> {
      //Note: Just a mock but enought
      let result = arc4random() % 9 == 0 ? false : true
      return Observable.just(result)
   }
}
