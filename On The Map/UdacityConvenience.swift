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
                
            } else {
                completionHandlerForLogin(success: success, errorString: errorString)
            }
        }
        
    }
    
    private func createSession(username: String, password: String, completionHandlerForSession: (success: Bool, userKey: String?, errorString: String?) -> Void) {
        
        
        
    }
    
    private func getUserInfo(userKey: String?, completionHandlerForUserInfo: (success: Bool, firstName: String?, lastName: String?) -> Void) {
        
    }
}