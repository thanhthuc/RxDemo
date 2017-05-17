//
//  ProfileViewController.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 3/15/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
   
   @IBOutlet weak var signoutButton: UIButton!
   var disposeBag = DisposeBag()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
      navigationItem.setHidesBackButton(true, animated: false)
      setupToBind()
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func setupToBind() {
      signoutButton.rx.tap.debug().subscribe { (event) in
         _ = self.navigationController?.popToRootViewController(animated: true)
      }.addDisposableTo(disposeBag)
   }
}
