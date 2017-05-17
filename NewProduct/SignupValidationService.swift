//
//  DefaultImplementation.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 02/03/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift
import Foundation


class SignupDefaultValidationService: SignupValidationService {
   
   let API: SignupAPI
   
   static let sharedService = SignupDefaultValidationService(API: SignupDefaultAPI.sharedSignupAPI)
   
   init(API: SignupAPI) {
      self.API = API
   }
   
   func validateUsername(_ username: String) -> Observable<ValidationResult> {
      
      if username.characters.count == 0 {
         return .just(.empty)
      }
      if (username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil) {
         return .just(.failed(message: "Can only contain numbers or digits"))
      }
      
      let loadingValue = ValidationResult.validating
      
      return API.usernameAvailable(username: username).map({ (available) in
         if available {
            return .ok(message: "Username available")
         } else {
            return .failed(message: "Username already taken")
         }
      }).startWith(loadingValue)
   }
   
   func validatePassword(_ password: String) -> ValidationResult {
      let minimumPassword = 5
      if password.characters.count == 0 {
         return .empty
      }
      if password.characters.count < minimumPassword {
         return .failed(message: "password less than \(minimumPassword)")
      }
      return .ok(message: "This is valid password")
   }
   
   func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult {
      
      //same character
      if repeatedPassword.characters.count == 0 {
         return .empty
      }
      if password == repeatedPassword {
         return .ok(message: "Message matched")
      }
      return .failed(message: "Message not matched")
   }
}

