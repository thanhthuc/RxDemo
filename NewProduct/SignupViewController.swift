//
//  ViewController.swift
//  NewProduct
//
//  Created by Nguyễn Thành Thực on 3/1/17.
//  Copyright © 2017 nguyen thanh thuc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
   @IBOutlet weak var usernameTextField: UITextField!
   @IBOutlet weak var validUsernameLabel: UILabel!
   @IBOutlet weak var passwordTextField: UITextField!
   @IBOutlet weak var validPasswordLabel: UILabel!
   @IBOutlet weak var repeatPasswordTextField: UITextField!
   @IBOutlet weak var validRepeatPasswordLabel: UILabel!
   @IBOutlet weak var signUpButton: UIButton!
   
   @IBOutlet weak var signingIndicator: UIActivityIndicatorView!
   
   
   var viewModel: SignupViewModelType!
   
   let disposeBag = DisposeBag()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      initSubView()
      initViewModel()
      bindViewModelToView()
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func initSubView() {
      signingIndicator.hidesWhenStopped = true
   }
   
   func initViewModel() {
      viewModel = SignupViewModel(input: (
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
         repeatedPassword: repeatPasswordTextField
            .rx
            .text
            .orEmpty
            .asObservable(),
         loginTaps: signUpButton
            .rx
            .tap
            .asObservable()), dependency: (API: SignupDefaultAPI.sharedSignupAPI,
                                               validationService: SignupDefaultValidationService.sharedService))
   }
   
   func bindViewModelToView() {
      
      viewModel.signupEnabled.subscribe(onNext: {[weak self] (valid) in
         self?.signUpButton.isEnabled = valid
         self?.signUpButton.alpha = valid ? 1 : 0.5
      }).addDisposableTo(disposeBag)
      
      viewModel.validatedUserName
         .bindTo(validUsernameLabel
            .rx
            .validationResult)
         .disposed(by: disposeBag)
      
      viewModel.validatedPassword
         .bindTo(validPasswordLabel
            .rx
            .validationResult)
         .disposed(by: disposeBag)
      
      viewModel.validatedRepeatPassword
         .bindTo(validRepeatPasswordLabel
            .rx
            .validationResult)
         .disposed(by: disposeBag)
      
      viewModel.signingIn
         .bindTo(signingIndicator
            .rx.isAnimating)
         .addDisposableTo(disposeBag)
      
      viewModel.signedIn.subscribe(onNext: { (signedIn) in
         print("singed in: \(signedIn)")
         let profileVC = StoryBoard.instance.instantiateViewController(withIdentifier: "ProfileViewController")
        self.navigationController?.pushViewController(profileVC, animated: true)
      }).addDisposableTo(disposeBag)
      
      let tapGesture = UITapGestureRecognizer()
      self.view.addGestureRecognizer(tapGesture)
      tapGesture.rx.event.asObservable().subscribe { (event) in
         self.usernameTextField.endEditing(true)
         self.passwordTextField.endEditing(true)
         self.repeatPasswordTextField.endEditing(true)
         }.addDisposableTo(disposeBag)
   }
}

