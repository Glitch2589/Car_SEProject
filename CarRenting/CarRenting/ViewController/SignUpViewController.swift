//
//  SignupViewController.swift
//  CarRenting
//
//  Created by Hoàng Quyết on 11/30/20.
//  Copyright © 2020 HaZuWy. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PhonenumTextField: UITextField!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var SignupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProfileImage.layer.cornerRadius = 55
        SignupButton.layer.cornerRadius = 20
    }

    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
