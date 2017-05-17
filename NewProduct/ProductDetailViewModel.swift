//
//  ProductDetailViewModel.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 18/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

protocol ProductDetailViewModelType: class {
   
   var productDetailObservable: Observable<Product> {get}
   
   var isLoading: Observable<Bool> {get}
}

class ProductDetailViewModel: ProductDetailViewModelType {
   
   var productDetailObservable: Observable<Product>
   var isLoading: Observable<Bool>
   
   init(productId: Int) {
      
      let isLoading = ActivityIndicator()
      self.isLoading = isLoading.asObservable()
      
      let activityIndicator = ActivityIndicator()
      self.isLoading = activityIndicator.asObservable()
      
      self.productDetailObservable = APIRequest.sharedAPI.productDetail(productId: productId).map({ (product) in
         
         return product
      }).observeOn(MainScheduler.instance).trackActivity(activityIndicator)
   }
   
}
