//
//  Protocol.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 02/03/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SignupAPI {
   
   func usernameAvailable(username: String) -> Observable<Bool>
   
   func signup(username: String, password: String) -> Observable<Bool>
}

protocol SignupValidationService {
   
   func validateUsername(_ username: String) -> Observable<ValidationResult>
   
   func validatePassword(_ password: String) -> ValidationResult
   
   func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult
}

protocol LoginAPI {
   
   func usernameAndPassAvailable(username: String, password: String) -> Observable<Bool>
   
   func login(username: String, password: String) -> Observable<Bool>
}


protocol LogInValidationService {
   
   func checkEmpty(_ username: String, password: String) -> Observable<ValidationResult>
}



