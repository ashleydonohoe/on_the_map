//
//  LoginViewController.swift
//  On The Map
//
//  Created by Ashley Donohoe on 8/26/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    

    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        
        activity.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginToUdacity(sender: AnyObject) {
        
        if usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            showAlert("Username and/or password is empty!")
        } else {
            setUIEnabled(false)
            
            activity.hidden = false
            activity.startAnimating()
            
            UdacityClient.sharedInstance().loginWithUdacity(usernameTextField.text!, password: passwordTextField.text!, hostViewController: self, completionHandlerForLogin: { (success, errorString) in
                if success {
                    performUIUpdatesOnMain({
                        self.activity.stopAnimating()
                        self.activity.hidden = true
                        self.completeUdacityLogin()
                    })
                } else {
                    performUIUpdatesOnMain({
                        self.showAlert(errorString!)
                        self.activity.stopAnimating()
                        self.activity.hidden = true
                        self.setUIEnabled(true)
                    })
                }
            })
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
    
// Code for showing UIAlertController. Adapted from https://www.appcoda.com/uialertcontroller-swift-closures-enum/
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController.addAction(defaultAction)
        presentViewController(alertController, animated: true, completion: nil)
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
