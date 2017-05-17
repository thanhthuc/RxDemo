//
//  ProductViewModel.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 07/03/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol ProductViewModelType: class {
   
   var productObservable: Observable<[Product]> { get }
   var isLoading: Observable<Bool> { get }
}

class ProductViewModel: ProductViewModelType {
      
   var productObservable: Observable<[Product]>
   var isLoading: Observable<Bool>
   
   init() {
      let activityIndicator = ActivityIndicator()
      self.isLoading = activityIndicator.asObservable()
      
      self.productObservable = APIRequest.sharedAPI
         .products()
         .map({ (productsRespond) in
            return productsRespond.products
         })
         .observeOn(MainScheduler.instance)
         .trackActivity(activityIndicator)
      
      
      
      
      
   }
}
