//
//  ProductTableViewCell.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 07/03/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

class ProductTableViewCell: UITableViewCell {
   
   @IBOutlet weak var buyButton: UIButton!
   @IBOutlet weak var imageProduct: UIImageView!
   @IBOutlet weak var nameProduct: UILabel!
   @IBOutlet weak var priceProduct: UILabel!
   @IBOutlet weak var descriptionProduct: UILabel!
   
   var productID: Int?
   
   let disposeBag = DisposeBag()
   
   var cart = ShoppingCart.sharedCart
   
   var product: Product? {
      didSet {
         nameProduct.text = product!.productName
         priceProduct.text = product!.productPrice! + "USD"
         descriptionProduct.text = product!.addressName
         productID = product?.productId
      }
   }
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
      setUpToBind()
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      //super.setSelected(selected, animated: animated)
   }
   
   override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      initViews()
   }
   
   required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      initViews() 
   }
   
   func initViews() {
      selectedBackgroundView = UIView(frame: frame)
      selectedBackgroundView?.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 0.9, alpha: 0.8)
   }
   
   func setUpToBind() {
      buyButton.rx.tap.debug().subscribe { (event) in
         // Animate when add to card
         super.setSelected(true, animated: true)
         super.setSelected(false, animated: true)
         
         //add to cart
         self.cart.products.value.insert(self.product!)
         
         if var dictValue = self.cart.dict.value[self.product!.productId] {
            dictValue += 1
            self.cart.dict.value[self.product!.productId] = dictValue
         } else {
            self.cart.dict.value[self.product!.productId] = 1
         }
      }.addDisposableTo(disposeBag)
   }
}
