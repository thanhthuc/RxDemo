//
//  Singleton.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 26/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

class StoryBoard: NSObject {
   static let instance = UIStoryboard.init(name: "Main", bundle: Bundle.main)
}

struct ValidationColors {
   static let okColor = UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
   static let errorColor = UIColor.red
}
