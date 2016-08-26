//
//  LoginViewController.swift
//  On The Map
//
//  Created by Ashley Donohoe on 8/26/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let udacityClient = UdacityClient()

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginToUdacity(sender: AnyObject) {
        
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            statusLabel.text = "Username and/or password is empty!"
        } else {
            setUIEnabled(false)
            udacityClient.createSession(usernameTextField.text!, password: passwordTextField.text!) {
        }
    }
    
    func completeUdacityLogin() {
        performUIUpdatesOnMain {
            self.statusLabel.text = ""
            self.setUIEnabled(true)
            let controller = self.storyboard?.instantiateViewControllerWithIdentifier("LoginFinished") as! UITabBarController
            self.presentViewController(controller, animated: true, completion: nil)
        }
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    // Methods for hiding the keyboard
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func resignIfFirstResponder(textField: UITextField) {
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
    }
}

// UI Config adapted from MyFavoriteMovies
extension LoginViewController {
    private func setUIEnabled(enabled: Bool) {
        usernameTextField.enabled = enabled
        passwordTextField.enabled = enabled
        loginButton.enabled = enabled
        statusLabel.text = ""
        statusLabel.enabled = enabled
        
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
}
