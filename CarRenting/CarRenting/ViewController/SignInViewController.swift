//
//  SignInViewController.swift
//  CarRenting
//
//  Created by Hoàng Quyết on 12/1/20.
//  Copyright © 2020 HaZuWy. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        //text field
//        UsernameTextField.backgroundColor = .clear
        UsernameTextField.attributedPlaceholder = NSAttributedString(string: UsernameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGreen])
        PasswordTextField.attributedPlaceholder = NSAttributedString(string: PasswordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGreen])
        LoginButton.layer.cornerRadius = 20
        SignupButton.layer.cornerRadius = 20
    }


}
