//
//  CartViewController.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 11/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

class CartViewController: UIViewController {
   
   let cart = ShoppingCart.sharedCart
   
   @IBOutlet weak var totalLabel: UILabel!
   @IBOutlet weak var costLabel: UILabel!
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var checkoutButton: UIButton!
   
   @IBOutlet weak var resetCardButton: UIButton!
   @IBOutlet weak var indicator: UIActivityIndicatorView!
   
   var viewModel: CheckoutViewModel!
   
   let disposeBag = DisposeBag()
   let imageCatched = NSCache<AnyObject, AnyObject>()
   let APICheckoutCard = CheckoutProduct.sharedCheckoutAPI
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
      //setTextAll()
      tableViewSetup()
      initViewModel()
      setUpForBindToView()
      indicator.hidesWhenStopped = true
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   
   func tableViewSetup() {
      tableView.estimatedRowHeight = 60
      tableView.rowHeight = UITableViewAutomaticDimension
      cart
         .products
         .asObservable()
         .bindTo(tableView
            .rx
            .items(cellIdentifier: "cellCheckout", cellType: ItemSelectedTableViewCell.self))
         {[weak self] (row, itemSelected, cell) in
            
            //other property
            cell.itemSelected = itemSelected
            
            //Now we cached image
            let urlString = itemSelected.productImageUrl
            if let cachedImage = self?.imageCatched.object(forKey: urlString as AnyObject) as? UIImage {
               cell.productImage.image = cachedImage
            } else {
               //download image from url
               let url = URL(string: urlString)
               var data: Data?
               
               DispatchQueue.global(qos: .background).async {
                  
                  data = try? Data.init(contentsOf: url!)
                  guard let data = data else {
                     return
                  }
                  let image = UIImage(data: data)
                  self?.imageCatched.setObject(image!, forKey: urlString as AnyObject)
                  
                  /* do some thing to cache image */
                  DispatchQueue.main.async {
                     cell.productImage.image = image
                  }
               }
            }
         }.addDisposableTo(disposeBag)
   }
   
   
   func initViewModel() {
      
      let priceTotal = Float(totalLabel.text!)
      var price: Float
      if let priceTotal = priceTotal {
         price = priceTotal
      } else {
         price = 0
      }
      
      let receipt = Receipt(receiptName: "ABC", priceTotal: price, userId: 1)
      viewModel = CheckoutViewModel(API: APICheckoutCard, input: (receipt: receipt, checkOutTap: checkoutButton.rx.tap.asObservable()))
   }
   
   func setUpForBindToView()  {
      
      viewModel.checking
         .bindTo(indicator
            .rx
            .isAnimating)
         .addDisposableTo(disposeBag)
      
      viewModel
         .checkoutValid
         .subscribe(onNext: { (valid) in
            if valid {
               let checkoutVC = StoryBoard.instance.instantiateViewController(withIdentifier: "CheckoutViewController")
               self.navigationController?.pushViewController(checkoutVC, animated: true)
            }
         }).addDisposableTo(disposeBag)
      
      
      cart.dict.asObservable().subscribe { (dictEvent) in
         self.costLabel.text = "Cost: \(self.cart.totalCost()) USD"
         self.totalLabel.text = "Total: \(self.cart.totalCount()) item"
         }.addDisposableTo(disposeBag)
      
      resetCardButton.rx.tap.subscribe { (event) in
         
         if self.cart.products.value.count > 0 {
            let alert = UIAlertController(title: "",
                                          message: "Reset or No?",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: { (action) in
                                          self.cart.products.value.removeAll()
                                          self.cart.dict.value.removeAll()
                                          _ = self.navigationController?.popViewController(animated: true)
            })
            let cancelAction = UIAlertAction(title: "CANCEL",
                                             style: .cancel,
                                             handler: { (action) in})
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
         }
         
         }.addDisposableTo(disposeBag)
      
      
   }
}
