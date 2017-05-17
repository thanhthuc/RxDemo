//
//  GitHubViewModel.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 3/2/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SignupViewModelType: class {
   
   var validatedUserName: Observable<ValidationResult> { get }
   
   var validatedPassword: Observable<ValidationResult> { get }
   
   var validatedRepeatPassword: Observable<ValidationResult> { get }
   
   // Is signup button enabled
   var signupEnabled: Observable<Bool> { get }
   
   // Has user signed in
   var signedIn: Observable<Bool> { get }
   
   // Is signing process in progress
   var signingIn: Observable<Bool> { get }
}

class SignupViewModel: SignupViewModelType {
   
   var validatedUserName: Observable<ValidationResult>
   var validatedPassword: Observable<ValidationResult>
   var validatedRepeatPassword: Observable<ValidationResult>
   var signupEnabled: Observable<Bool>
   var signedIn: Observable<Bool>
   var signingIn: Observable<Bool>
   
   init(input:
      (username: Observable<String>,
      password: Observable<String>,
      repeatedPassword: Observable<String>,
      loginTaps: Observable<Void>),
        dependency:
      (API: SignupAPI,
      validationService: SignupValidationService)) {
      
      //init
      let password = input.password
      let username = input.username
      let repeatedPassword = input.repeatedPassword
      let loginTap = input.loginTaps
      
      let API = dependency.API
      let validService = dependency.validationService
      
      // Pure transformation of input sequences to output sequences.
      // Init service
      
      validatedUserName = username.flatMapLatest({ (username) in
         return validService.validateUsername(username)
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(.failed(message: "fail to connect to server"))
      }).shareReplay(1)
      
      validatedPassword = password.map({ (password) in
         return validService.validatePassword(password)
      }).shareReplay(1)
      
      validatedRepeatPassword = Observable
         .combineLatest(password,
                        repeatedPassword,
                        resultSelector: {
                           (password, repeatedPassword) in
                           return validService
                              .validateRepeatedPassword(password, repeatedPassword: repeatedPassword)
         }).shareReplay(1)
      
      
      let signingIn = ActivityIndicator()
      self.signingIn = signingIn.asObservable()
      
      let usernameAndPassword = Observable
         .combineLatest(username, password) {
            (username, password) in
            return (username, password)
      }
      
      signedIn = loginTap
         .withLatestFrom(usernameAndPassword)
         .flatMapLatest({ (username, password) -> Observable<Bool> in
            
            return API.signup(username: username, password: password)
               .observeOn(MainScheduler.instance)
               .catchErrorJustReturn(false)
               .trackActivity(signingIn)
         })
         .shareReplay(1)
      
      signupEnabled = Observable
         .combineLatest(validatedUserName,
                        validatedPassword,
                        validatedRepeatPassword,
                        signingIn.asObservable(),
                        resultSelector:
            { (username, password, repeatedPassword, signedIn) in
               let result = (username.isValid && password.isValid && repeatedPassword.isValid && !signedIn)
               return result
         })
         .distinctUntilChanged()
         .shareReplay(1)
   }
}





