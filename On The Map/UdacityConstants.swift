//
//  UdacityConstants.swift
//  On The Map
//
//  Created by Gabriele on 8/25/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    // Constants
    struct Constants {
        
        // For URL
        static let ApiScheme: String = "https"
        static let ApiHost = "www.udacity.com"
        static let ApiPath = "api"
    }
    
    // API methods
    struct Methods {
        static let UserInfo = "/users/{id}"
        static let Session = "/session"
    }
    
    // Parameter keys
    struct ParameterKeys {
        
    }
}