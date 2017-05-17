//
//  CheckoutViewController.swift
//  NewProduct
//
//  Created by Nguyen Thanh Thuc on 11/04/2017.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {
   
   @IBOutlet weak var cartNumberTextField: UITextField!
   @IBOutlet weak var expTextField: UITextField!
   @IBOutlet weak var cvvTextField: UITextField!
   
   @IBOutlet weak var buyProductButton: UIButton!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func validateBill() {
      //check if Validating text field
   }
   
}
