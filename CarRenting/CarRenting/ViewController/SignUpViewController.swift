//
//  SignupViewController.swift
//  CarRenting
//
//  Created by Hoàng Quyết on 11/30/20.
//  Copyright © 2020 HaZuWy. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class SignUpViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PhonenumTextField: UITextField!
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var SignupButton: UIButton!
    
    
    
    var selectedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProfileImage.layer.cornerRadius = 55
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.handleSelectProfileImageView))
        ProfileImage.addGestureRecognizer(tapGesture)
        ProfileImage.isUserInteractionEnabled = true
        
        SignupButton.layer.cornerRadius = 20
        
        handleTextField()
    }
    
    func handleTextField() {
        UsernameTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        EmailTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        PasswordTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
        PhonenumTextField.addTarget(self, action: #selector(SignUpViewController.textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc func textFieldDidChange(){
        guard let username = UsernameTextField.text, !username.isEmpty, let email = EmailTextField.text, !email.isEmpty, let password = PasswordTextField.text, !password.isEmpty, let phonenum = PhonenumTextField.text, !phonenum.isEmpty else {
            SignupButton.setTitleColor(UIColor.lightText, for: UIControl.State.normal)
            SignupButton.isEnabled = false
            return

        }
        SignupButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        SignupButton.isEnabled = true
    }
    
    @objc func handleSelectProfileImageView(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }

    
    @IBAction func dismiss_onClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func signup_TouchUpInside(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: EmailTextField.text!, password: PasswordTextField.text!) { (user, error) in
            if error != nil{
                print(error!.localizedDescription)
                return
            }
            
            let uid = user?.user.uid
            let storageRef = Storage.storage().reference(forURL: "gs://seproject-4261e.appspot.com").child("profile_image").child(uid!)
            if let profileImg = self.selectedImage, let imageData = profileImg.jpegData(compressionQuality: 0.1) {
                storageRef.putData(imageData, metadata: nil, completion: {(metadata, error) in
                    if error != nil {
                        return
                        
                    }
                    //let profileImgUrl = storageRef.downloadURL.absoluteString
                    storageRef.downloadURL { url, error in
                      if let error = error {
                        print(error.localizedDescription)
                      } else {
                        let profileImgUrl = url?.absoluteString
                        self.setUserInformation(profileImgageUrl: profileImgUrl!, username: self.UsernameTextField.text!, email: self.EmailTextField.text!, phonenum: self.PhonenumTextField.text!, uid: uid!)
                      }
                    }
                    
                })
            }
        }
        
    }
    
    func setUserInformation(profileImgageUrl: String, username: String, email: String, phonenum: String, uid: String) {
        
        let ref = FirebaseDatabase.DatabaseReference()
        let userReference = ref.child("users")

        let newUserReference = userReference.child(uid)
        
        newUserReference.setValue(["username": username, "email": email, "phone number": phonenum, "profileImgUrl": profileImgageUrl])
        self.performSegue(withIdentifier: "signUpToTabBarVC", sender: nil)
    }
    
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("finished")
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage{
            selectedImage = image
            ProfileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
