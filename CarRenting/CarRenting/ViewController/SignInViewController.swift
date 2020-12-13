//
//  SignInViewController.swift
//  CarRenting
//
//  Created by Hoàng Quyết on 12/1/20.
//  Copyright © 2020 HaZuWy. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!    
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var SignupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        //text field
//        emailTextField.backgroundColor = .clear
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGreen])
        PasswordTextField.attributedPlaceholder = NSAttributedString(string: PasswordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGreen])
        LoginButton.layer.cornerRadius = 20
        SignupButton.layer.cornerRadius = 20
        
        handleTextField()
    }

    func handleTextField() {
        emailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        PasswordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(){
        guard let email = emailTextField.text, !email.isEmpty, let password = PasswordTextField.text, !password.isEmpty else {
            LoginButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            LoginButton.isEnabled = false
            return

        }
        LoginButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        LoginButton.isEnabled = true
    }
    
    @IBAction func loginButton_TouchUpInside(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: PasswordTextField.text!) { (user, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            self.performSegue(withIdentifier: "signInToTabBarVC", sender: nil)
        }
    }
}
