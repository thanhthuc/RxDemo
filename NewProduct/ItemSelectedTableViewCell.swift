//
//  ItemSelectedTableViewCell.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 13/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

class ItemSelectedTableViewCell: UITableViewCell {
   
   @IBOutlet weak var productImage: UIImageView!
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var priceLabel: UILabel!
   @IBOutlet weak var totalItemLabel: UILabel!
   
   @IBOutlet weak var inscreaseButton: UIButton!
   @IBOutlet weak var descreaseButton: UIButton!
   
   let cart = ShoppingCart.sharedCart
   var disposeBag = DisposeBag()
   
   var itemSelected: Product? {
      didSet {
         nameLabel.text = itemSelected?.productName
         priceLabel.text = itemSelected!.productPrice! + "USD"
         let itemCount = cart.dict.value[itemSelected!.productId]
         totalItemLabel.text = "\(itemCount!) item"
      }
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      
      //Observable inscrease button
      inscreaseButton.rx.tap.subscribe { (event) in
         self.cart.dict.value[(self.itemSelected?.productId)!]! += 1
      }.addDisposableTo(disposeBag)
      
      //Observable descrease button
      descreaseButton.rx.tap.subscribe { (event) in
         let numItemProduct = self.cart.dict.value[(self.itemSelected?.productId)!]!
         if numItemProduct > 0 {
            self.cart.dict.value[(self.itemSelected?.productId)!]! -= 1
         }
      }.addDisposableTo(disposeBag)
      
      //label listen event changed number of item
      cart.dict.asObservable().subscribe { (dict) in
         if let itemSelected = self.itemSelected {
            if let numOfItem = dict.element![itemSelected.productId] {
               self.totalItemLabel.text = "\(numOfItem) item"
            }
         }
      }.addDisposableTo(disposeBag)
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
   
   
   
   
}
