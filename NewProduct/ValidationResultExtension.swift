//
//  ValidationResultExtension.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 26/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

extension ValidationResult: CustomStringConvertible {
   
   var description: String {
      switch self {
      case let .ok(message):
         return message
      case .empty:
         return " "
      case .validating:
         return "Validating ..."
      case let .failed(message):
         return message
      }
   }
   var textColor: UIColor {
      switch self {
      case .ok:
         return ValidationColors.okColor
      case .empty:
         return UIColor.black
      case .validating:
         return UIColor.black
      case .failed:
         return ValidationColors.errorColor
      }
   }
   
   var isValid: Bool {
      switch self {
      case .ok:
         return true
      default:
         return false
      }
   }
}

