//
//  LoginViewModel.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 07/03/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

protocol LoginViewModelType: class {
   
   var signinEnabled: Observable<Bool> { get }
   
   var validSignIn: Observable<Bool> { get }
   
   var signingIn: Observable<Bool> { get }
   
   var bothUserAndPassNotEmpty: Observable<ValidationResult> { get }
}

class LoginViewModel: LoginViewModelType {
   
   var signinEnabled: Observable<Bool>
   var validSignIn: Observable<Bool>
   var signingIn: Observable<Bool>
   var bothUserAndPassNotEmpty: Observable<ValidationResult>
   
   init(input: (username: Observable<String>,
      password: Observable<String>,
      loginTaps: Observable<Void>),
        dependence: (API: LoginAPI,
      ValidationService: LogInValidationService)) {
      
      let signingIn = ActivityIndicator()
      self.signingIn = signingIn.asObservable()
      
      let usernameAndPassword = Observable.combineLatest(input.username, input.password) {($0, $1)}
      
      self.bothUserAndPassNotEmpty = usernameAndPassword
         .flatMapLatest({
            (username, pass) in
         return dependence.ValidationService.checkEmpty(username, password: pass)
      })
         .observeOn(MainScheduler.instance)
      
      self.signinEnabled = Observable
         .combineLatest(bothUserAndPassNotEmpty,
                        signingIn.asObservable(),
                        resultSelector:
         { (bothCorrect, signed)  in
            if bothCorrect.isValid && !signed {
               return true
            }
            return false
      }).shareReplay(1)
      
      //final, when we can tap to button, we will valid status
      self.validSignIn = input
         .loginTaps
         .withLatestFrom(usernameAndPassword)
         .flatMapLatest({ (username, pass) in
         
         return dependence.API
            .usernameAndPassAvailable(username: username, password: pass)
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(false)
            .trackActivity(signingIn)
      })
         .shareReplay(1)
   }
}
