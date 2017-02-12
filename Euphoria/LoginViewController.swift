//
//  LoginViewController.swift
//  Euphoria
//
//  Created by Annie Tung on 12/15/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.delegate = self
        passwordField.delegate = self
        // get the current user by listening for updates to auth objects
        let _ = FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            self.updateInterface()
        })
        addGestureToDismissKeyboard()
    }
    
    func updateInterface() {
        if let _ = FIRAuth.auth()?.currentUser {
            self.loginButton.setTitle("Sign out", for: .normal)
        } else {
            self.loginButton.setTitle("Sign in", for: .normal)
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

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                self.updateInterface()
            } catch {
                print("Error logging in: \(error.localizedDescription)")
            }
        } else if let email = emailField.text,
            let password = passwordField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                if user != nil {
                    print("User signed in")
                } else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let email = emailField.text,
            let password = passwordField.text {
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                if user != nil {
                    print("User registered")
                } else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
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
