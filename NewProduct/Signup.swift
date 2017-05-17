//
//  Signup.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 3/15/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

final class SignupDefaultAPI: SignupAPI {
   
   static let sharedSignupAPI = SignupDefaultAPI()

   func usernameAvailable(username: String) -> Observable<Bool> {
      
      return APIRequest.sharedAPI
         .signup(username: username)
         .map({ (signupRespond) -> Bool in
         return (signupRespond.statusCode != 2)
      })
   }
   
   func signup(username: String, password: String) -> Observable<Bool> {
      // this is also just a mock
      let signupResult = arc4random() % 9 == 0 ? false : true
      
      return Observable
         .just(signupResult)
         .delay(1.0, scheduler: MainScheduler.instance)
   }
}
