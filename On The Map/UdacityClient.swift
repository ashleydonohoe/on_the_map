//
//  UdacityClient.swift
//  On The Map
//
//  Created by Ashley Donohoe on 8/25/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {
    
    
    // Method for building Udacity URL
    func buildUdacityURL(withPathExtension: String?) -> NSURL {
        let components = NSURLComponents()
        components.scheme = Constants.ApiScheme
        components.host = Constants.ApiHost
        components.path = Constants.ApiPath
        
        return components.URL!
    }
    
    //TODO: Add function for posting session
    func createSession(username: String, password: String) {
        print("Creating session")
        
        
        let url = buildUdacityURL(Methods.Session)
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \(username), \"password\": \(password)}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(request) { (data, response, error) in
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                print("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? NSHTTPURLResponse)?.statusCode where statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            /* 5. Parse the data */
            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            } catch {
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
        }
        task.resume()
    }
    
    //TODO: Add function for getting user info
    func getUserInfo(userID: Int) {
        
    }
    
    //TODO: Add function for deleting session
    func closeSession() {
        
    }
    
}