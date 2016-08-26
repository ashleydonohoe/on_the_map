//
//  UdacityClient.swift
//  On The Map
//
//  Created by Gabriele on 8/25/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {
    
    
    // Method for building Udacity URL
    func buildUdacityURL(withPathExtension: String?) -> NSURL {
        let components = NSURLComponents()
        components.scheme = Constants.ApiScheme
        components.host = Constants.ApiHost
        components.path = Constants.ApiPath + (withPathExtension ?? "")
        
        return components.URL!
    }
    
    //TODO: Add function for posting session
    func createSession(username: String, password: String) {
        
    }
    
    //TODO: Add function for getting user info
    func getUserInfo(userID: Int) {
        
    }
    
    //TODO: Add function for deleting session
    func closeSession() {
        
    }
    
}