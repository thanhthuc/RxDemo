//
//  LogInValidationService.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 4/30/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

class LogInDefaultValidationService: LogInValidationService {
   
   let API: LoginDefaultAPI
   
   static let sharedService = LogInDefaultValidationService(API: LoginDefaultAPI.sharedLoginAPI)
   
   init(API: LoginDefaultAPI) {
      self.API = API
   }
   
   func checkEmpty(_ username: String, password: String) -> Observable<ValidationResult> {
      
      if username.characters.count == 0 || password.characters.count == 0 {
         return .just(.empty)
      } else {
         return .just(.ok(message: "Ready"))
      }
   }
   
}
