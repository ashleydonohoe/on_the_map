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
        static let ApiScheme: String = "https"
        static let ApiHost = "udacity.com"
        static let ApiPath = "/api"
    }
    
    // API methods
    struct Methods {
        static let UserInfo = "/users/{id}"
        static let Session = "/session"
    }
    
    // JSON Body Keys
    struct JSONBodyKeys {
        static let Username = "username"
        static let Password = "password"
        static let UdacityDictionary = "udacity"
    }
    
    // JSON Response Keys
    struct JSONResponseKeys {
        static let Account = "account"
        static let Session = "session"
        static let User = "user"
        static let UserKey = "key"
        static let FirstName = "first_name"
        static let LastName = "last_name"
    }

    
}