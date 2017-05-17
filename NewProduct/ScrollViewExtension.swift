//
//  ScrollViewExtension.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 5/2/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

extension UIScrollView {
   func  isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
      return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
   }
}
