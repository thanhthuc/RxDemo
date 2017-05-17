//
//  StringExtension.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 26/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

extension String {
   var URLEscaped: String {
      return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
   }
}
