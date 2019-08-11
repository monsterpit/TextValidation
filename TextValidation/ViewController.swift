//
//  ViewController.swift
//  TextValidation
//
//  Created by MB on 8/10/19.
//  Copyright © 2019 MB. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginEnabledLabel: UILabel!
    
    var loginViewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       _ = emailTextField.rx.text.map{$0 ?? ""}.bind(to: loginViewModel.emailText)
       _ = passwordTextField.rx.text.map{$0 ?? ""}.bind(to: loginViewModel.passwordText)
        
       _ = loginViewModel.isValid.bind(to: loginButton.rx.isEnabled)
        
        loginViewModel.isValid.subscribe(onNext : { [unowned self] isValid in
            self.loginEnabledLabel.text = isValid ? "Enabled" : "Not Enabled"
            self.loginEnabledLabel.textColor = isValid ? .green : .red
            print("isValid \(isValid)")
        }).addDisposableTo(disposeBag)
        
    }


}

