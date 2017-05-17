//
//  CheckoutViewModel.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 17/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

protocol CheckoutViewModelType: class {
   
   var checking: Observable<Bool> { get }
   
   var checkoutValid: Observable<Bool> { get }
}

class CheckoutViewModel: NSObject {
   var checking: Observable<Bool>
   var checkoutValid: Observable<Bool>
   
   init(API: CheckoutProduct, input: (receipt: Receipt, checkOutTap: Observable<Void>)) {
      
      let trackActivity = ActivityIndicator()
      checking = trackActivity.asObservable()
      
      checkoutValid = input
         .checkOutTap
         .flatMapLatest({ () -> Observable<Bool> in
         
         return API.checkoutProducts(forReceipt: input.receipt)
            .observeOn(MainScheduler.instance)
            .catchErrorJustReturn(false)
            .trackActivity(trackActivity)
      }).shareReplay(1)
   }
}
