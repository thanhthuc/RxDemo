//
//  GitHubSignInViewController.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 3/2/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginViewController: UIViewController {
   
   @IBOutlet weak var usernameTextField: UITextField!
   @IBOutlet weak var passwordTextField: UITextField!
   @IBOutlet weak var validUserLabel: UILabel!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   @IBOutlet weak var signInButton: UIButton!
   
   var viewModel: LoginViewModelType!
   let disposeBag = DisposeBag()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view.
      initView()
      initLoginViewModel()
      bindToView()
   }
   
   func initView() {
      activityIndicator.hidesWhenStopped = true
   }
   
   func initLoginViewModel() {
      viewModel = LoginViewModel(input: (
         username: usernameTextField
            .rx
            .text
            .orEmpty
            .asObservable(),
         password: passwordTextField
            .rx
            .text
            .orEmpty
            .asObservable(),
         loginTaps: signInButton
            .rx
            .tap
            .asObservable()), dependence:
         (API: LoginDefaultAPI.sharedLoginAPI,
          ValidationService: LogInDefaultValidationService.sharedService))
   }
   
   func bindToView() {
      viewModel.signinEnabled.subscribe(onNext: { (enable) in
         self.signInButton.isEnabled = enable
         self.signInButton.alpha = enable ? 1 : 0.5
         
      }, onError: { (error) in
         print(error.localizedDescription)
      }, onCompleted: {
         print("complete")
      }) {
         print("Released")
         }.addDisposableTo(disposeBag)
      
      viewModel.bothUserAndPassNotEmpty
         .bindTo(validUserLabel
            .rx
            .validationResult)
         .addDisposableTo(disposeBag)
      
      viewModel.signingIn
         .bindTo(activityIndicator
            .rx
            .isAnimating)
         .addDisposableTo(disposeBag)
      
      viewModel.validSignIn.subscribe(onNext: { (valid) in
         
         if valid {
            let productsVC = StoryBoard.instance.instantiateViewController(withIdentifier: "ProductsViewController")
            self.navigationController?.pushViewController(productsVC, animated: true)
         }
         
      }).addDisposableTo(disposeBag)
      
      let tapGesture = UITapGestureRecognizer()
      self.view.addGestureRecognizer(tapGesture)
      tapGesture.rx.event.asObservable().subscribe { (event) in
         self.usernameTextField.endEditing(true)
         self.passwordTextField.endEditing(true)
      }.addDisposableTo(disposeBag)
      
      
   }
   
}
