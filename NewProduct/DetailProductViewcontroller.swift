//
//  DetailViewcontroller.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 18/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

class DetailProductViewcontroller: UIViewController {
   
   @IBOutlet weak var productImage: UIImageView!
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var restaurantNameLabel: UILabel!
   @IBOutlet weak var addressNameLabel: UILabel!
   @IBOutlet weak var ratingLabel: UILabel!
   @IBOutlet weak var urlRelativeLabel: UILabel!
   @IBOutlet weak var placeInMapButton: UIButton!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
   var mapPoint: MapPoint!
   
   var mapPointObservable: Observable<MapPoint>!
   
   var productId: Int = 0
   var viewModel: ProductDetailViewModelType!
   var disposeBag = DisposeBag()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      viewModel = ProductDetailViewModel(productId: productId)
      activityIndicator.hidesWhenStopped = true
      setUpForBinding()
      mapPoint = MapPoint(longitute: 0, latitute: 0)
   }
   
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
      let destVC = segue.destination as! MapViewController
      destVC.mapPoint = mapPoint
      
   }
   
   func setUpForBinding() {
      
      viewModel
         .isLoading
         .bindTo(activityIndicator
            .rx
            .isAnimating)
         .addDisposableTo(disposeBag)
      viewModel
         .productDetailObservable
         .subscribe(onNext: { (productDetail) in
            
         let url = URL(string: productDetail.productImageUrl)
         let data = NSData(contentsOf: url!)
         if let data = data {
            let image = UIImage(data: data as Data)
            self.productImage.image = image
         }
         self.nameLabel.text = productDetail.productName
         self.restaurantNameLabel.text = productDetail.restaurantName
         self.addressNameLabel.text = productDetail.addressName
         self.ratingLabel.text = productDetail.rating
         self.urlRelativeLabel.text = productDetail.urlrelate
         
         self.mapPoint.longitute = productDetail.longitude!
         self.mapPoint.latitute = productDetail.latitude!
            
      }).addDisposableTo(disposeBag)
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
}
