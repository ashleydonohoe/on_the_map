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
            
            self.getUserInfo(self.userID, completionHandlerForUserInfo: { (success, firstName, lastName) in
                if success {
                    if let firstName = firstName, lastName = lastName {
                        self.firstName = firstName
                        self.lastName = lastName
                        print(firstName)
                        print(lastName)
                    }
                    
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
    
    private func getUserInfo(userKey: String?, completionHandlerForUserInfo: (success: Bool, firstName: String?, lastName: String?) -> Void) {
        print("Getting user info")
        
    }
}