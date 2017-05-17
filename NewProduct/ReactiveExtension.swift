//
//  ReactiveExtension.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 26/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UILabel {
   var validationResult: UIBindingObserver <Base, ValidationResult> {
      return UIBindingObserver(UIElement: base, binding: { (label, result) in
         label.textColor = result.textColor
         label.text = result.description
      })
   }
}
