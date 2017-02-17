//
//  LoginViewController.swift
//  Euphoria
//
//  Created by Annie Tung on 12/15/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        configureConstraints()
        emailField.delegate = self
        passwordField.delegate = self
        addGestureToDismissKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("Almost out of memory!")
    }
    
    // MARK: - Views
    
    var emailField: UITextField = {
        let field = UITextField()
        field.placeholder = " Email"
        field.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        return field
    }()
    
    var passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = " Password"
        field.isSecureTextEntry = true
        field.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        return field
    }()
    
    var loginButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("LOGIN", for: .normal)
        button.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(nil, action: #selector(loginButtonPressed), for: .touchUpInside)
        return button
    }()
    
    var registerButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("REGISTER", for: .normal)
        button.addTarget(nil, action: #selector(registerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Set Up
    
    func setupHierarchy() {
        let _ = [emailField, passwordField, loginButton, registerButton].map{ self.view.addSubview($0) }
    }
    
    func configureConstraints() {
        
        emailField.snp.makeConstraints { (view) in
            view.centerX.centerY.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.7)
            view.height.equalTo(25)
        }
        
        passwordField.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(emailField.snp.bottom).offset(15)
            view.width.equalTo(emailField.snp.width)
            view.height.equalTo(emailField.snp.height)
        }
        
        loginButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(passwordField.snp.bottom).offset(20)
            view.width.equalTo(passwordField.snp.width)
        }
        
        registerButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(loginButton.snp.bottom).offset(10)
        }
    }
    
    // MARK: - Keyboard
    
    func addGestureToDismissKeyboard() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func loginButtonPressed() {
        if let email = emailField.text, let password = passwordField.text{
            loginButton.isEnabled = false
            
            if FIRAuth.auth()?.currentUser != nil {
                FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                    if error != nil {
                        print("Error encountered loggin in: \(error?.localizedDescription)")
                    }
                    if user != nil {
                        let alert = UIAlertController(title: "Welcome back!", message: nil, preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }
                    else {
                        let alert = UIAlertController(title: "Failed!", message: error?.localizedDescription, preferredStyle: .alert)
                        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(ok)
                        self.present(alert, animated: true, completion: nil)
                    }
                    self.loginButton.isEnabled = true
                })
            }
        }
    }
    
    func registerButtonPressed() {
        if let email = emailField.text, let password = passwordField.text {
            registerButton.isEnabled = false
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    print("Error encountered while creating new authentication: \(error?.localizedDescription)")
                }
                if user != nil {
                    print("User registered")
                    let alert = UIAlertController(title: "Welcome!", message: "Thanks for joining our family", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Failed to register!", message: error?.localizedDescription, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
                self.registerButton.isEnabled = true
            })
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.passwordField {
            view.endEditing(true)
            return false
        }
        return true
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
