//
//  ListProductViewController.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 3/2/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: UIViewController {
   
   static let startLoadingOffset: CGFloat = 20.0
   
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var indicator: UIActivityIndicatorView!
   @IBOutlet weak var searchBar: UISearchBar!
   var barBadgeButton : BadgetButton!
   
   @IBOutlet weak var toProfileButton: UIBarButtonItem!
   
   var viewModel: ProductViewModelType!
   let disposeBag = DisposeBag()
   let imageCatched = NSCache<AnyObject, AnyObject>()
   
   let cart = ShoppingCart.sharedCart
   
   //catch image
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      
      bindToTableView()
      setUpCartImage()
      setUpCell()
      initSubView()
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      if segue.identifier == "detail" {
         let indexPath = tableView.indexPath(for: (sender as! UITableViewCell))
         let cell = tableView.cellForRow(at: indexPath!) as! ProductTableViewCell
         let des = segue.destination as! DetailProductViewcontroller
         des.productId = cell.productID!
      }
   }
   
   override func viewWillAppear(_ animated: Bool) {
      //navigationSetup()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func initSubView() {
      indicator.hidesWhenStopped = true
      navigationItem.setHidesBackButton(true, animated: false)
   }
   
   func bindToTableView() {
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.estimatedRowHeight = 60
      viewModel = ProductViewModel()
      
      //we observable string from search bar
      let searchBar = self.searchBar
         .rx
         .text
         .orEmpty
         .debounce(0.5, scheduler: MainScheduler.instance)
         .distinctUntilChanged()
      
      let searchBarObservable = searchBar
         .flatMapLatest {[weak self] (string) -> Observable<[Product]> in
            
            return (self?.viewModel.productObservable
               .flatMapLatest({ (products) -> Observable<[Product]> in
                  
                  let productsRes = products.filter({ (product) -> Bool in
                     return  (product.addressName.contains(string) ||
                        product.productName.contains(string) ||
                        product.productPrice!.contains(string) ||
                        string == "")
                  })
                  return .just(productsRes)
               }))!
      }
      
      viewModel.productObservable.concat(searchBarObservable)
         .bindTo(tableView.rx.items(cellIdentifier: "cellProduct", cellType: ProductTableViewCell.self)) {[weak self] (row, product, cell) in
            
            cell.product = product
            
            //Now we cached image
            let urlString = product.productImageUrl
            if let cachedImage = self?.imageCatched.object(forKey: urlString as AnyObject) as? UIImage {
               cell.imageProduct.image = cachedImage
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
                     cell.imageProduct.image = image
                  }
               }
            }
         }.addDisposableTo(disposeBag)
      viewModel.isLoading.bindTo(indicator.rx.isAnimating).addDisposableTo(disposeBag)
      
      toProfileButton.rx.tap.asObservable().subscribe { (event) in
         let profileVC = StoryBoard.instance
            .instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
         self.navigationController?.pushViewController(profileVC, animated: true)
         }.addDisposableTo(disposeBag)
   }
   
   func setUpCartImage() {
      let customButton = UIButton(type: UIButtonType.custom)
      customButton.frame = CGRect(x: 0, y: 0, width: 35.0, height: 35.0)
      customButton.setImage(UIImage(named: "Cart"), for: .normal)
      customButton
         .rx
         .tap
         .debug()
         .subscribe(onNext: { (event) in
            let cartVC = StoryBoard.instance
               .instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            self.navigationController?.pushViewController(cartVC, animated: true)
            
         })
         .addDisposableTo(disposeBag)
      
      barBadgeButton = BadgetButton()
      barBadgeButton.setup(customButton: customButton)
      barBadgeButton.badgeValue = "0"
      barBadgeButton.badgeOriginX = 20.0
      barBadgeButton.badgeOriginY = -4
      
      navigationItem.rightBarButtonItem = barBadgeButton
      
      cart
         .dict
         .asObservable()
         .subscribe(onNext: { (dict) in
            self.barBadgeButton.badgeValue = "\(self.cart.totalCount())"
         })
         .addDisposableTo(disposeBag)
   }
   
   func setUpCell() {
      tableView.rx.itemSelected.subscribe(onNext: { indexPath in
         if self.searchBar.isFirstResponder == true {
            self.view.endEditing(true)
         }
      }).addDisposableTo(disposeBag)
   }
}


