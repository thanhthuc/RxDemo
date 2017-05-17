//
//  InfinitescrollActivityView.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 30/03/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
   
   var activityIndicatorView = UIActivityIndicatorView()
   static let defaultHeight: CGFloat = 60.0
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setupActivityIndicator()
   }
   
   override init(frame: CGRect) {
      super.init(frame: frame)
   }
   
   override func layoutSubviews() {
      super.layoutSubviews()
      activityIndicatorView.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
   }
   
   func setupActivityIndicator() {
      activityIndicatorView.activityIndicatorViewStyle = .gray
      activityIndicatorView.hidesWhenStopped = true
      self.addSubview(activityIndicatorView)
   }
   
   func stopAnimating() {
      self.activityIndicatorView.stopAnimating()
      self.isHidden = true
   }
   
   func startAnimating() {
      self.isHidden = false
      self.activityIndicatorView.startAnimating()
   }
   
}
