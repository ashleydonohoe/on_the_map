//
//  UdacityConstants.swift
//  On The Map
//
//  Created by Gabriele on 8/25/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    struct Constants {
        // For URL
        static let BaseURL = "https://www.udacity.com/api"
    }
    
    // API methods
    struct Methods {
        static let UserInfo = "/users/"
        static let Session = "/session"
    }
    
    // JSON Response Keys
    struct JSONResponseKeys {
        static let Account = "account"
        static let Session = "session"
        static let User = "user"
        static let UserKey = "key"
        static let FirstName = "first_name"
        static let LastName = "last_name"
        static let Registered = "registered"
    }
    
    struct ErrorMessages {
        static let ConnectionError = "Could not connect to Udacity"
        static let LoginError = "Username or password is incorrect"
        static let LogoutError = "Could not logout"
    }

    
}