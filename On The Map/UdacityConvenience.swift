//
//  UdacityConvenience.swift
//  On The Map
//
//  Created by Gabriele on 8/28/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation
import UIKit

extension UdacityClient {
    
    func loginWithUdacity(username: String, password: String, hostViewController: UIViewController, completionHandlerForLogin: (success: Bool, errorString: String?) -> Void) {
        
       createSession(username, password: password) { (success, userKey, errorString) in
        if success {
            
            print(userKey)
            self.userID = userKey
            
            self.getUserInfo(self.userID, completionHandlerForUserInfo: { (success, firstName, lastName, errorString) in
                if success {
                    if let firstName = firstName, lastName = lastName {
                        self.firstName = firstName
                        self.lastName = lastName
                    }
                    completionHandlerForLogin(success: true, errorString: nil)
                } else {
                    completionHandlerForLogin(success: success, errorString: errorString)
                }
            })
                
            } else {
                completionHandlerForLogin(success: success, errorString: errorString)
            }
        }
    }
    
    private func createSession(username: String, password: String, completionHandlerForSession: (success: Bool, userKey: String?, errorString: String?) -> Void) {
        
        let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}"
        
        udacityTaskForLoginMethod(jsonBody) { (result, error) in
            if let error = error {
                print(error)
                completionHandlerForSession(success: false, userKey: nil, errorString: "Login Failed (Invalid credentials")
                self.showUdacityAlert("Invalid Credentials")
            } else {
                if let accountStatus = result![JSONResponseKeys.Account] as? [String: AnyObject] where (accountStatus[JSONResponseKeys.Registered] as? Bool == true) {
                    
                    let userKey = accountStatus[JSONResponseKeys.UserKey] as? String
                    completionHandlerForSession(success: true, userKey: userKey, errorString: nil)
                } else {
                    completionHandlerForSession(success: false, userKey: nil, errorString: "Cannot find registered status")
                }
            }
        }
        
    }
    
    private func getUserInfo(userKey: String?, completionHandlerForUserInfo: (success: Bool, firstName: String?, lastName: String?, errorString: String?) -> Void) {
        print("Getting user info")
        let urlString = Constants.BaseURL + Methods.UserInfo + userID!
        let url = NSURL(string: urlString)
        print(url)
        
        udacityTaskForGetUserInfoMethod { (result, error) in
            if let error = error {
                print(error)
                completionHandlerForUserInfo(success: false, firstName: nil, lastName: nil, errorString: "Couldn't get user info")
            } else {
                if let userInfo = result[JSONResponseKeys.User] as? [String: AnyObject],
                lastName = userInfo[JSONResponseKeys.LastName] as? String,
                    firstName = userInfo[JSONResponseKeys.FirstName] as? String {
                    completionHandlerForUserInfo(success: true, firstName: firstName, lastName: lastName, errorString: nil)
                    
                } else {
                    completionHandlerForUserInfo(success: false, firstName: nil, lastName: nil, errorString: "Could not locate first and last name")
                }
            }
        }

    }
    
    // Instruction on adding AlertView taken from http://code.tutsplus.com/tutorials/ios-fundamentals-uialertview-and-uialertcontroller--cms-24038
    
    private func showUdacityAlert(alertText: String) {
        let alertView = UIAlertView(title: "Login Error", message: alertText, delegate: self, cancelButtonTitle: "OK")
        alertView.tag = 1
        alertView.show()
    }
}