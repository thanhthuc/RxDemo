
//
//  ValidationResultEnum.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 27/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

enum ValidationResult {
   case ok(message: String)
   case empty
   case validating
   case failed(message: String)
}

